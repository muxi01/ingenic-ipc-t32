import socket, ssl, re, sys, os, subprocess, time

HOST, PORT = "192.168.172.1", 554
BASE = f"rtsp://{HOST}:{PORT}/ch0"
OUT = sys.argv[1] if len(sys.argv) > 1 else "snapshot.jpg"

ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
ctx.load_cert_chain("config/plain_cert/cam_cert.pem", "config/plain_cert/cam_key.pem")

s = socket.create_connection((HOST, PORT), timeout=8)
t = ctx.wrap_socket(s, server_hostname=HOST)
t.settimeout(8)
print("[*] TLS OK:", t.cipher())


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
r = send("DESCRIBE", BASE, {"Accept": "application/sdp"}).decode(errors="replace")
trs = re.findall(r"a=control:(trackID=\d+)", r)
if not trs:
    print("[!] no tracks found"); sys.exit(1)
print("[*] tracks:", trs)

sess = None
vid_inter = None
for i, tr in enumerate(trs):
    inter = f"{i*2}-{i*2+1}"
    r = send("SETUP", f"{BASE}/{tr}",
             {"Transport": f"RTP/AVP/TCP;unicast;interleaved={inter}"})
    rr = r.decode(errors="replace")
    m = re.search(r"Session:\s*(\S+)", rr)
    if m:
        sess = m.group(1).split(";")[0]
    # 以 SETUP 实际返回的 interleaved 通道为准
    m = re.search(r"Transport:.*interleaved=(\d+)-(\d+)", rr)
    ch_low = int(m.group(1)) if m else i * 2
    if i == 0:
        vid_inter = ch_low
    print(f"[*] SETUP {tr}: interleaved ch={ch_low}-{ch_low+1} session={sess}")

r = send("PLAY", BASE, {"Session": sess})
print("[*] PLAY:", r.split(b"\r\n", 1)[0].decode())

STREAM_START = bytes.fromhex("00000001")


def depayload_h264(payload):
    """把单个 H.264 RTP payload 还原成 Annex-B (起始码 + NAL)。"""
    if len(payload) < 2:
        return b""
    nal_type = payload[0] & 0x1F
    out = b""
    if nal_type in range(1, 24):          # 单 NAL 单元 (含 SPS=7/PPS=8/IDR=5)
        out = STREAM_START + payload
    elif nal_type == 28:                  # FU-A
        fu_ind, fu_head = payload[0], payload[1]
        if fu_head & 0x80:                # S=1 起始片
            nal = bytes([(fu_ind & 0xE0) | (fu_head & 0x1F)])
            out = STREAM_START + nal + payload[2:]
        else:                             # 续片
            out = payload[2:]
    elif nal_type == 24:                  # STAP-A
        p = payload[1:]
        while len(p) >= 2:
            sz = int.from_bytes(p[0:2], "big")
            p = p[2:]
            if len(p) < sz:
                break
            out += STREAM_START + p[:sz]
            p = p[sz:]
    return out


# 抓取原始 H264 到临时文件，随后用 ffmpeg 抽取一帧
h264 = "/tmp/_snap.h264"
video_fh = open(h264, "wb")

# 先录 ~2 秒整段（涵盖几个 GOP），停止后抽取中间干净的关键帧
DUR = 2.0
start = time.time()
buf = b""
idr_cnt = 0
vpk = 0
try:
    while time.time() - start < DUR:
        if not buf:
            buf = t.recv(65536)
            if not buf:
                break
        if len(buf) < 4:
            buf += t.recv(65536)
            continue
        magic, chan = buf[0], buf[1]
        plen = int.from_bytes(buf[2:4], "big")
        if len(buf) < 4 + plen:
            buf += t.recv(65536)
            continue
        pkt = buf[4:4 + plen]
        buf = buf[4 + plen:]
        if len(pkt) < 12:
            continue
        pt = pkt[1] & 0x7F
        if chan != vid_inter or pt != 96:   # 只要视频 H264 通道
            continue
        data = depayload_h264(pkt[12:])
        if data:
            # 统计 IDR，确保至少抓到一组关键帧
            if b"\x00\x00\x00\x01\x65" in data or b"\x00\x00\x01\x65" in data:
                idr_cnt += 1
            video_fh.write(data)
            vpk += 1
except socket.timeout:
    pass
finally:
    video_fh.close()

print(f"[*] 缓冲完成: 视频包 {vpk}, IDR {idr_cnt}, {os.path.getsize(h264)}B")
if idr_cnt == 0:
    print("[!] 未捕获到 H264 关键帧"); t.close(); sys.exit(1)

t.close()
cmd = ["ffmpeg", "-y", "-loglevel", "error", "-f", "h264", "-i", h264,
       "-frames:v", "1", "-q:v", "2", OUT]
r = subprocess.run(cmd, capture_output=True, text=True)
if os.path.exists(OUT) and os.path.getsize(OUT) > 0:
    print(f"[OK] 快照已保存: {OUT} ({os.path.getsize(OUT)}B)")
else:
    print("[!] ffmpeg 解码失败:", r.stderr.strip()[:500])
os.remove(h264)