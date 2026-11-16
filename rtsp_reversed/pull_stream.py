import socket, ssl, hashlib, re, sys

HOST, PORT = "192.168.172.1", 554
BASE = f"rtsp://{HOST}:{PORT}/ch0"

ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
ctx.load_cert_chain("config/plain_cert/cam_cert.pem", "config/plain_cert/cam_key.pem")

s = socket.create_connection((HOST, PORT), timeout=8)
t = ctx.wrap_socket(s, server_hostname=HOST)
t.settimeout(8)
print("TLS OK:", t.cipher())


def send(method, url, headers, body=b""):
    head = f"{method} {url} RTSP/1.0\r\nCSeq: {send.seq}\r\n"
    for k, v in headers.items():
        head += f"{k}: {v}\r\n"
    if body:
        head += f"Content-Length: {len(body)}\r\n"
    head += "\r\n"
    send.seq += 1
    t.sendall(head.encode() + body)
    # read headers
    buf = b""
    while b"\r\n\r\n" not in buf:
        buf += t.recv(4096)
    header, _, rest = buf.partition(b"\r\n\r\n")
    lines = header.decode(errors="replace").split("\r\n")
    status = lines[0]
    hdrs = {}
    for ln in lines[1:]:
        if ":" in ln:
            k, v = ln.split(":", 1)
            hdrs[k.strip()] = v.strip()
    clen = int(hdrs.get("Content-Length", 0) or 0)
    while clen > len(rest):
        rest += t.recv(4096)
    return status, hdrs, rest[:clen]


send.seq = 1

# 1) OPTIONS
st, hd, bd = send("OPTIONS", BASE, {"User-Agent": "t"})
print("== OPTIONS ==", st)

# 2) DESCRIBE (possibly needs auth -> parse challenge)
st, hd, bd = send("DESCRIBE", BASE, {"Accept": "application/sdp"})
print("== DESCRIBE ==", st)
ww = hd.get("WWW-Authenticate")
if ww:
    print("WWW-Authenticate:", ww)
m = re.search(r'realm="([^"]+)"', ww or "")
realm = m.group(1) if m else ""
m = re.search(r'nonce="([^"]+)"', ww or "")
nonce = m.group(1) if m else ""
qop = "auth" if "qop" in (ww or "") else ""

USER, PASS = "admin", (sys.argv[1] if len(sys.argv) > 1 else "admin")

def auth_header(method, uri):
    if not realm and not nonce:
        return ""
    ha1 = f"{USER}:{realm}:{PASS}"
    ha1 = hashlib.md5(ha1.encode()).hexdigest()
    ha2 = hashlib.md5(f"{method}:{uri}".encode()).hexdigest()
    resp = hashlib.md5(f"{ha1}:{nonce}:{ha2}".encode()).hexdigest()
    return (f'Digest username="{USER}", realm="{realm}", nonce="{nonce}", '
            f'uri="{uri}", response="{resp}", algorithm=MD5' + (f', qop={qop}' if qop else ""))

# If 401, retry DESCRIBE with auth
if "401" in st:
    ah = auth_header("DESCRIBE", BASE)
    st, hd, bd = send("DESCRIBE", BASE, {"Accept": "application/sdp", "Authorization": ah})
    print("== DESCRIBE (with auth) ==", st)
    if "401" in st:
        print(">>> Digest 密码不正确, 401. Quit.")
        t.close()
        sys.exit(2)
sdp = bd.decode(errors="replace")
print("SDP:\n" + sdp)

# Parse tracks (control + setup addr)
tracks = re.findall(r"a=control:(trackID=\d+)", sdp)
if not tracks:
    tracks = re.findall(r"a=control:(\S+)", sdp)
print("tracks:", tracks)

# 3+4) SETUP each track, then PLAY
sess = None
for idx, tr in enumerate(tracks):
    inter = f"{idx*2}-{idx*2+1}"
    url = f"{BASE}/{tr}"
    st, hd, bd = send("SETUP", url,
        {"Transport": f"RTP/AVP/TCP;unicast;interleaved={inter}"})
    if "401" in st and (realm or nonce):
        ah = auth_header("SETUP", url)
        st, hd, bd = send("SETUP", url,
            {"Transport": f"RTP/AVP/TCP;unicast;interleaved={inter}",
             "Authorization": ah})
    print(f"== SETUP {tr} ==", st, hd)
    sess = hd.get("Session", sess)

st, hd, bd = send("PLAY", BASE, {"Session": sess})
if "401" in st and (realm or nonce):
    ah = auth_header("PLAY", BASE)
    st, hd, bd = send("PLAY", BASE, {"Session": sess, "Authorization": ah})
print("== PLAY ==", st, hd)
if "200" not in st:
    print("PLAY failed; stopping.")
    t.close()
    sys.exit(3)

print("=== 播放中，读取媒体帧... (Ctrl-C 停止) ===")
print("解析互型封装: 4字节通道 + 2字节长度 + RTP包")
try:
    leftover = bd
    while True:
        if len(leftover) < 4:
            leftover += t.recv(4096)
            continue
        chan = int.from_bytes(leftover[0:1], "big")
        plen = int.from_bytes(leftover[2:4], "big")
        while len(leftover) < 4 + plen:
            leftover += t.recv(4096)
        pkt = leftover[4:4 + plen]
        leftover = leftover[4 + plen:]
        pt = (pkt[1] & 0x7F) if len(pkt) > 1 else -1
        print(f"interleaved ch={chan} len={plen} RTP_PT={pt} "
              f"first={pkt[12:16].hex() if len(pkt) > 16 else ''}")
except KeyboardInterrupt:
    print("stopped.")
finally:
    t.close()