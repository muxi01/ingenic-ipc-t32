#!/usr/bin/env python3
"""Send a PIXI config frame to BU config service (port 6000, mTLS) to trigger talkback service creation.

Frame format (see TALK_逆向获取记录.md 8.2.3):
    [0..3]   "PIXI"
    [4..5]   word0  BE16   (echoed back by BU)
    [6..7]   type   BE16   (0..18; talkback config = 11)
    [8..11]  len    BE32   (= 16 + body_len + 2)
    [12..15] reserved BE32 (0)
    [16..]   body (JSON string)
    [len-2..len-1] CRC16 BE (poly 0xa001, init 0xffff, covers frame[0:len-2])

Talkback config handler = type 11 (jump table 0x5e2540 -> 0x44433c), required flat keys:
    enable     : number, {0,1}   (1 = create/enable talkback)
    codec      : number, {0,1}  (0=G.711 µ-law, 1=G.711 A-law; 均 8bit→16bit 解码, 640B→1280B)
    samplerate : number, [8000,16000]
    frame_len  : number, <2049   (samples per frame; 640 = 40ms@16kHz)
    volume     : number, [-30,60] (optional)
"""
import argparse
import os
import socket
import ssl
import struct
import sys

BASE = os.path.dirname(os.path.abspath(__file__))
DEFAULT_HOST = "192.168.172.1"
DEFAULT_PORT = 6000
DEFAULT_CA = os.path.join(BASE, "config", "plain_cert", "ca_cert.pem")
DEFAULT_CERT = os.path.join(BASE, "config", "plain_cert", "cam_cert.pem")
DEFAULT_KEY = os.path.join(BASE, "config", "plain_cert", "cam_key.pem")


def crc16(frame):
    crc = 0xFFFF
    for b in frame:
        crc ^= b
        for _ in range(8):
            if crc & 1:
                crc = (crc >> 1) ^ 0xA001
            else:
                crc >>= 1
    return crc & 0xFFFF


def build_frame(frame_type, body):
    total = 16 + len(body) + 2
    head = b"PIXI"
    head += struct.pack(">H", 0)
    head += struct.pack(">H", frame_type)
    head += struct.pack(">I", total)
    head += struct.pack(">I", 0)
    frame = head + body
    c = crc16(frame)
    return frame + struct.pack(">H", c)


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


def recv_exact(sock, n):
    buf = b""
    while len(buf) < n:
        chunk = sock.recv(n - len(buf))
        if not chunk:
            raise EOFError("connection closed, got %d of %d bytes" % (len(buf), n))
        buf += chunk
    return buf


def recv_response(sock, timeout=5.0):
    sock.settimeout(timeout)
    magic = recv_exact(sock, 4)
    if magic != b"PIXI":
        raise ValueError("bad response magic: %r" % magic)
    hdr = recv_exact(sock, 12)
    word0, rtype, total, reserved = struct.unpack(">HHII", hdr)
    rest = recv_exact(sock, total - 16)
    body = rest[:total - 18]
    crc_rx = rest[total - 18:]
    crc_calc = crc16(magic + hdr + body)
    if crc_calc != struct.unpack(">H", crc_rx)[0]:
        raise ValueError("response CRC mismatch: got 0x%04x want 0x%04x (word0=0x%04x type=%d len=%d body=%r)"
                         % (struct.unpack(">H", crc_rx)[0], crc_calc, word0, rtype, total, body))
    print("response: word0=0x%04x type=%d len=%d reserved=0x%08x crc=0x%04x"
          % (word0, rtype, total, reserved, crc_calc))
    print("body: %s" % body.decode("utf-8", "replace"))
    return word0, rtype, body


def main():
    ap = argparse.ArgumentParser(description="trigger talkback service on BU via config-service PIXI frame")
    ap.add_argument("--host", default=DEFAULT_HOST, help="BU ip address (default: %(default)s)")
    ap.add_argument("--port", type=int, default=DEFAULT_PORT, help="config service port (default: %(default)s)")
    ap.add_argument("--type", type=int, default=11, help="frame type, talkback config = 11 (default: %(default)s)")
    ap.add_argument("--json", default='{"enable":1,"codec":0,"samplerate":16000,"frame_len":640}',
                    help="body JSON (default: %(default)s)")
    ap.add_argument("--ca", default=DEFAULT_CA)
    ap.add_argument("--cert", default=DEFAULT_CERT)
    ap.add_argument("--key", default=DEFAULT_KEY)
    ap.add_argument("--seclevel0", action="store_true", help="use DEFAULT:@SECLEVEL=0 for old tls stacks")
    ap.add_argument("--timeout", type=float, default=5.0, help="response read timeout (default: %(default)s)")
    args = ap.parse_args()

    body = args.json.encode("utf-8")
    frame = build_frame(args.type, body)
    print("PIXI frame: type=%d len=%d crc=0x%04x" % (args.type, len(frame), crc16(frame)))

    print("connecting to %s:%d (mTLS) ..." % (args.host, args.port))
    try:
        sock = tls_connect(args.host, args.port, args.ca, args.cert, args.key, args.seclevel0)
    except Exception as e:
        print("handshake failed: %r" % e, file=sys.stderr)
        sys.exit(2)
    print("connected, tls version: %s, cipher: %s" % (sock.version(), sock.cipher()))

    print("sending PIXI frame ...")
    sock.sendall(frame)
    try:
        recv_response(sock, args.timeout)
    except (EOFError, socket.timeout, ssl.SSLError, OSError, ValueError) as e:
        print("no/invalid response: %r" % e, file=sys.stderr)
    finally:
        try:
            sock.close()
        except OSError:
            pass


if __name__ == "__main__":
    main()