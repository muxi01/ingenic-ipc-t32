import socket, ssl, re, sys, time, os

HOST, PORT = "192.168.172.1", 554
BASE = f"rtsp://{HOST}:{PORT}/ch0"

OUT_PREFIX = sys.argv[1] if len(sys.argv) > 1 else "stream"
DUR = float(sys.argv[2]) if len(sys.argv) > 2 else 0.0  # 秒, 0 = 直到 Ctrl-C

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
chan_sdp = {}
for i, tr in enumerate(trs):
    inter = f"{i*2}-{i*2+1}"
    r = send("SETUP", f"{BASE}/{tr}",
             {"Transport": f"RTP/AVP/TCP;unicast;interleaved={inter}"})
    # 抓 SETUP 返回里的 session/transport
    rr = r.decode(errors="replace")
    m = re.search(r"Session:\s*(\S+)", rr)
    if m:
        sess = m.group(1).split(";")[0]
    m = re.search(r"Transport:.*interleaved=(\d+)-(\d+)", rr)
    ch_low = int(m.group(1)) if m else i * 2
    chan_sdp[ch_low] = (i, tr)
    print(f"[*] SETUP {tr}: interleaved ch={ch_low}-{ch_low+1} session={sess}")

r = send("PLAY", BASE, {"Session": sess})
print("[*] PLAY:", r.split(b"\r\n", 1)[0].decode())

# ---- 根据已经 log 的 RTP 总是 PT96(视频)/98(音频)，通道用 SETUP 返回的 ----
# H.264 RTP depayload -> Annex-B 写入 .h264；音频 RTP payload 直接追加 .raw
video_fh = open(f"{OUT_PREFIX}.h264", "wb")
audio_fh = open(f"{OUT_PREFIX}.aac", "wb")

STREAM_START = bytes.fromhex("00000001")
start = time.time()


def depayload_h264(payload):
    """把单个 H.264 RTP payload 还原成 Annex-B (起始码 + NAL)。"""
    if len(payload) < 2:
        return b""
    nal_type = payload[0] & 0x1F
    out = b""
    if nal_type in range(1, 24):          # 单 NAL 单元
        out = STREAM_START + payload
    elif nal_type == 28:                  # FU-A
        fu_ind, fu_head = payload[0], payload[1]
        if fu_head & 0x80:                # S=1 起始片
            nal = bytes([(fu_ind & 0xE0) | (fu_head & 0x1F)])
            out = STREAM_START + nal + payload[2:]
        else:                             # 续片，直接拼接原始负载(去掉2字节FU头)
            out = payload[2:]
    elif nal_type == 24:                  # STAP-A 聚合
        p = payload[1:]
        while len(p) >= 2:
            sz = int.from_bytes(p[0:2], "big")
            p = p[2:]
            if len(p) < sz:
                break
            out += STREAM_START + p[:sz]
            p = p[sz:]
    # 其他类型(24/25/26/27/29/30/31)忽略
    return out


print(f"[*] 开始录制 -> {OUT_PREFIX}.h264 / {OUT_PREFIX}.aac  (Ctrl-C 停止)")
buf = b""
vpk = apk = 0
try:
    while True:
        if not buf:
            buf = t.recv(65536)
            if not buf:
                break
        # 拆 interleaved 帧: 4字节头(1字节$ + 1字节通道 + 2字节长度)
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
        payload = pkt[12:]                 # 去掉 RTP 头
        if pt == 96:                       # H.264
            data = depayload_h264(payload)
            if data:
                video_fh.write(data)
                vpk += 1
        elif pt == 98:                     # 音频 (AAC)
            audio_fh.write(payload)
            apk += 1
        if DUR and (time.time() - start) >= DUR:
            print(f"[*] 时长到 {DUR}s, 停止")
            break
except KeyboardInterrupt:
    print("[*] 用户中断")
finally:
    video_fh.close()
    audio_fh.close()
    t.close()
    print(f"[*] 完成: 视频包 {vpk}, 音频包 {apk}")
    print(f"[*] 生成 {OUT_PREFIX}.h264 {os.path.getsize(OUT_PREFIX+'.h264')}B, "
          f"{OUT_PREFIX}.aac {os.path.getsize(OUT_PREFIX+'.aac')}B")