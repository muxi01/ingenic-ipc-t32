import socket, ssl, re, sys, os, subprocess, time

HOST, PORT = "192.168.172.1", 554
BASE = f"rtsp://{HOST}:{PORT}/ch0"
OUT = sys.argv[1] if len(sys.argv) > 1 else "snapshot.jpg"
STREAM_START = bytes.fromhex("00000001")

ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
ctx.load_cert_chain("config/plain_cert/cam_cert.pem", "config/plain_cert/cam_key.pem")
s = socket.create_connection((HOST, PORT), timeout=8)
t = ctx.wrap_socket(s, server_hostname=HOST)
t.settimeout(8)


def send(method, url, hdrs):
    h = f"{method} {url} RTSP/1.0\r\nCSeq: {send.seq}\r\n"
    for k, v in hdrs.items():
        h += f"{k}: {v}\r\n"
    h += "\r\n"
    send.seq += 1
    t.sendall(h.encode())
    buf = b""
    while b"\r\n\r\n" not in buf:
        buf += t.recv(4096)
    return buf


send.seq = 1
send("OPTIONS", BASE, {"User-Agent": "t"})
resp = send("DESCRIBE", BASE, {"Accept": "application/sdp"}).decode(errors="replace")
trs = re.findall(r"a=control:(trackID=\d+)", resp)
if not trs:
    # 视频 SDP 的 track: 通常第一个是 H264 视频
    trs = [m for m in re.findall(r"a=control:(\S+)", resp)]
sess = None
vid_inter = None
for i, tr in enumerate(trs):
    inter = f"{i*2}-{i*2+1}"
    rr = send("SETUP", f"{BASE}/{tr}",
              {"Transport": f"RTP/AVP/TCP;unicast;interleaved={inter}"}).decode(errors="replace")
    m = re.search(r"Session:\s*(\S+)", rr)
    if m:
        sess = m.group(1).split(";")[0]
    m = re.search(r"interleaved=(\d+)-(\d+)", rr)
    if m and i == 0:
        vid_inter = int(m.group(1))
send("PLAY", BASE, {"Session": sess})

# 只抓视频通道: 重组 Annex-B 直到出现 >=2 个 IDR 帧 (保证有完整关键帧)
import io
raw = bytearray()
idr_cnt = 0
buf = b""


def nal_type_h264_slices(payload):
    """从 H264 RTP payload 提取 (nal_type) 列表, 用于统计 IDR。"""
    if len(payload) < 2:
        return []
    nt = payload[0] & 0x1F
    if nt in range(1, 24):
        return [nt]
    if nt == 24:  # STAP-A
        p, out = payload[1:], []
        while len(p) >= 2:
            sz = int.from_bytes(p[0:2], "big")
            p = p[2:]
            if len(p) < sz:
                break
            out.append(p[0] & 0x1F)
            p = p[sz:]
        return out
    if nt == 28:  # FU-A
        fu_head = payload[1]
        if fu_head & 0x80:   # 只在起始片计数
            return [(payload[0] & 0xE0) | (fu_head & 0x1F)]
    return []


deadline = time.time() + 30
try:
    while time.time() < deadline:
        if not buf:
            buf = t.recv(65536)
            if not buf:
                break
        if len(buf) < 4:
            buf += t.recv(65536)
            continue
        chan = buf[1]
        plen = int.from_bytes(buf[2:4], "big")
        if len(buf) < 4 + plen:
            buf += t.recv(65536)
            continue
        pkt = buf[4:4 + plen]
        buf = buf[4 + plen:]
        if len(pkt) < 12 or chan != vid_inter:
            continue
        pt = pkt[1] & 0x7F
        if pt != 96:          # 只要 H264
            continue
        payload = pkt[12:]
        # 写入 Annex-B
        ntlist = nal_type_h264_slices(payload)
        for nt in ntlist:
            if nt == 5:
                idr_cnt += 1
        if 28 == (payload[0] & 0x1F):     # FU-A
            fu_ind, fu_head = payload[0], payload[1]
            if fu_head & 0x80:
                raw += STREAM_START + bytes([(fu_ind & 0xE0) | (fu_head & 0x1F)]) + payload[2:]
            else:
                raw += payload[2:]
        else:                             # 单NAL / STAP-A: 原样加头(fmpeg 能解析)
            if (payload[0] & 0x1F) == 24:
                p, ok = payload[1:], True
                while len(p) >= 2:
                    sz = int.from_bytes(p[0:2], "big"); p = p[2:]
                    if len(p) < sz: ok = False; break
                    raw += STREAM_START + p[:sz]; p = p[sz:]
            elif (payload[0] & 0x1F) in range(1, 24):
                raw += STREAM_START + payload
        if idr_cnt >= 2:
            break
except socket.timeout:
    pass
finally:
    t.close()

if idr_cnt == 0:
    print("[!] 30s 内未捕获到 H264 关键帧"); sys.exit(1)

h264 = "/tmp/_snap.h264"
open(h264, "wb").write(bytes(raw))
print(f"[*] 抓到 {idr_cnt} 个IDR, 缓冲 {len(raw)}B -> 解码")

cmd = ["ffmpeg", "-y", "-loglevel", "error", "-f", "h264", "-i", h264,
       "-frames:v", "1", "-q:v", "2", OUT]
r = subprocess.run(cmd, capture_output=True, text=True)
if os.path.exists(OUT) and os.path.getsize(OUT) > 0:
    print(f"[OK] 快照已保存: {OUT} ({os.path.getsize(OUT)}B)")
else:
    print("[!] ffmpeg 解码失败:", r.stderr.strip()[:500])
os.remove(h264)