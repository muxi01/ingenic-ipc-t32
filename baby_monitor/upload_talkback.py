#!/usr/bin/env python3
import argparse
import math
import os
import socket
import ssl
import struct
import sys
import time
import wave

BASE = os.path.dirname(os.path.abspath(__file__))
DEFAULT_HOST = "192.168.172.1"
DEFAULT_CA = os.path.join(BASE, "config", "plain_cert", "ca_cert.pem")
DEFAULT_CERT = os.path.join(BASE, "config", "plain_cert", "cam_cert.pem")
DEFAULT_KEY = os.path.join(BASE, "config", "plain_cert", "cam_key.pem")

SAMPLE_RATE = 16000
FRAME_SAMPLES = 640                  # 640 samples = 40ms @ 16kHz
PCM_FRAME_BYTES = FRAME_SAMPLES * 2  # 1280 bytes S16LE per frame
G711_FRAME_BYTES = FRAME_SAMPLES     # 640 bytes G.711 (8-bit) per frame
SSRC = 0x54414C4B
# G.711 RTP payload types: A-law = 8, u-law = 0
PT = {"alaw": 8, "ulaw": 0}


def load_pcm(path):
    with wave.open(path, "rb") as w:
        nch = w.getnchannels()
        sw = w.getsampwidth()
        sr = w.getframerate()
        if nch != 1 or sw != 2:
            raise ValueError("only PCM S16LE mono wav is supported")
        if sr != SAMPLE_RATE:
            print("wav sample rate %d != %d, frames will be treated as %d" % (sr, SAMPLE_RATE, SAMPLE_RATE), file=sys.stderr)
        return w.readframes(w.getnframes())


def make_tone(duration, freq):
    n = int(SAMPLE_RATE * duration)
    buf = bytearray()
    for i in range(n):
        v = int(0.5 * 32767 * math.sin(2 * math.pi * freq * i / SAMPLE_RATE))
        buf += struct.pack("<h", v)
    return bytes(buf)


# ---- G.711 A-law / u-law encoders (16-bit S16LE -> 8-bit) ----

_ULAW_BIAS = 0x84    # 132, linear bias added to u-law magnitude
_ULAW_CLIP = 32635   # max magnitude before bias


def linear_to_ulaw(sample):
    """Encode a signed 16-bit sample to G.711 u-law (silence -> 0xFF)."""
    if sample < 0:
        sign = 0x80
        mag = -sample
    else:
        sign = 0x00
        mag = sample
    if mag > _ULAW_CLIP:
        mag = _ULAW_CLIP
    mag += _ULAW_BIAS
    if mag < 256:
        seg = 0
    elif mag < 512:
        seg = 1
    elif mag < 1024:
        seg = 2
    elif mag < 2048:
        seg = 3
    elif mag < 4096:
        seg = 4
    elif mag < 8192:
        seg = 5
    elif mag < 16384:
        seg = 6
    else:
        seg = 7
    mantissa = (mag >> (seg + 3)) & 0x0F
    return (~(sign | (seg << 4) | mantissa)) & 0xFF


def linear_to_alaw(sample):
    """Encode a signed 16-bit sample to G.711 A-law (silence -> 0xD5)."""
    v = sample >> 3  # 16-bit -> 13-bit (arithmetic shift)
    if v >= 0:
        sign = 0x80
        mag = v
    else:
        sign = 0x00
        mag = -v - 1
    if mag > 0xFFF:
        mag = 0xFFF
    if mag < 32:
        seg = 0
        step = mag >> 1
    elif mag < 64:
        seg = 1
        step = (mag - 32) >> 1
    elif mag < 128:
        seg = 2
        step = (mag - 64) >> 2
    elif mag < 256:
        seg = 3
        step = (mag - 128) >> 3
    elif mag < 512:
        seg = 4
        step = (mag - 256) >> 4
    elif mag < 1024:
        seg = 5
        step = (mag - 512) >> 5
    elif mag < 2048:
        seg = 6
        step = (mag - 1024) >> 6
    else:
        seg = 7
        step = (mag - 2048) >> 7
    return ((sign | (seg << 4) | step) ^ 0x55) & 0xFF


_CODECS = {"alaw": linear_to_alaw, "ulaw": linear_to_ulaw}


def encode_g711(pcm, codec):
    """Convert a S16LE PCM byte string to G.711 bytes (640 samples -> 640 bytes)."""
    enc = _CODECS[codec]
    samples = struct.unpack("<%dh" % (len(pcm) // 2), pcm)
    return bytes(enc(s) for s in samples)


def build_rtp_packet(seq, ts, payload, pt):
    header = struct.pack(">BBHII", 0x80, pt, seq & 0xFFFF, ts & 0xFFFFFFFF, SSRC)
    return header + payload


def build_interleaved(rtp_packet):
    return b"$" + b"\x00" + struct.pack(">H", len(rtp_packet)) + rtp_packet


def split_frames(raw):
    out = []
    for off in range(0, len(raw), PCM_FRAME_BYTES):
        c = raw[off:off + PCM_FRAME_BYTES]
        if len(c) < PCM_FRAME_BYTES:
            c += b"\x00" * (PCM_FRAME_BYTES - len(c))
        out.append(c)
    return out


def tls_connect(host, port, ca, cert, key, seclevel0):
    ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_REQUIRED
    ctx.load_verify_locations(cafile=ca)
    ctx.load_cert_chain(certfile=cert, keyfile=key)
    ctx.minimum_version = ssl.TLSVersion.TLSv1
    if seclevel0:
        ctx.set_ciphers("DEFAULT:@SECLEVEL=0")
    return ctx.wrap_socket(socket.create_connection((host, port), timeout=10))


def main():
    ap = argparse.ArgumentParser(description="upload G.711 audio to BU talkback (TCP mTLS :12345, interleaved+RTP)")
    ap.add_argument("--host", default=DEFAULT_HOST, help="BU ip address (default: %(default)s)")
    ap.add_argument("--port", type=int, default=12345)
    ap.add_argument("--codec", choices=sorted(PT), default="ulaw", help="G.711 codec, must match BU talkback config (default: %(default)s)")
    ap.add_argument("--file", help="wav file (PCM S16LE mono 16kHz)")
    ap.add_argument("--tone", action="store_true", help="generate sine tone instead of file")
    ap.add_argument("--freq", type=float, default=440.0)
    ap.add_argument("--duration", type=float, default=5.0)
    ap.add_argument("--fast", action="store_true", help="disable 40ms pacing")
    ap.add_argument("--probe", action="store_true", help="only test tls handshake")
    ap.add_argument("--ca", default=DEFAULT_CA)
    ap.add_argument("--cert", default=DEFAULT_CERT)
    ap.add_argument("--key", default=DEFAULT_KEY)
    ap.add_argument("--seclevel0", action="store_true", help="use DEFAULT:@SECLEVEL=0 for old tls stacks")
    args = ap.parse_args()

    if args.probe:
        print("testing tls handshake to %s:%d ..." % (args.host, args.port))
        try:
            sock = tls_connect(args.host, args.port, args.ca, args.cert, args.key, args.seclevel0)
        except Exception as e:
            print("handshake failed: %r" % e, file=sys.stderr)
            sys.exit(2)
        print("connected, tls version: %s, cipher: %s" % (sock.version(), sock.cipher()))
        sock.close()
        return

    if args.file:
        raw = load_pcm(args.file)
    elif args.tone:
        raw = make_tone(args.duration, args.freq)
    else:
        ap.error("need --file or --tone")

    pcm_frames = split_frames(raw)
    if not pcm_frames:
        ap.error("no audio data")

    pt = PT[args.codec]
    frames = [encode_g711(p, args.codec) for p in pcm_frames]

    print("connecting to %s:%d (mTLS) ..." % (args.host, args.port))
    try:
        sock = tls_connect(args.host, args.port, args.ca, args.cert, args.key, args.seclevel0)
    except Exception as e:
        print("handshake failed: %r" % e, file=sys.stderr)
        sys.exit(2)
    print("connected, sending %d G.711 %s frames (%d bytes each) ..." % (len(frames), args.codec, G711_FRAME_BYTES))

    seq = 0
    ts = 0
    start = time.time()
    try:
        for payload in frames:
            sock.sendall(build_interleaved(build_rtp_packet(seq, ts, payload, pt)))
            seq += 1
            ts += FRAME_SAMPLES
            if not args.fast:
                time.sleep(FRAME_SAMPLES / SAMPLE_RATE)
    except (BrokenPipeError, ConnectionResetError, ssl.SSLError, OSError) as e:
        print("connection closed by peer: %r" % e, file=sys.stderr)
        sys.exit(3)
    finally:
        try:
            sock.close()
        except OSError:
            pass

    elapsed = time.time() - start
    print("done, %d frames in %.2fs" % (len(frames), elapsed))


if __name__ == "__main__":
    main()