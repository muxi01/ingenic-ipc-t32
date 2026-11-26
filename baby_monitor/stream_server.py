import socket, ssl, re, os, sys, time, threading, subprocess
from http.server import ThreadingHTTPServer, BaseHTTPRequestHandler

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
RTSP_HOST = "192.168.172.1"
RTSP_PORT = 554
BASE = f"rtsp://{RTSP_HOST}:{RTSP_PORT}/ch0"
HTTP_PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8080
CERT_DIR = os.path.join(BASE_DIR, "config", "plain_cert")
CERT = os.path.join(CERT_DIR, "cam_cert.pem")
KEY = os.path.join(CERT_DIR, "cam_key.pem")
FFMPEG = "/usr/bin/ffmpeg"
STREAM_START = bytes.fromhex("00000001")

state_cond = threading.Condition()
latest_jpeg = None
frame_seq = 0
running = True


def depayload_h264(payload):
    if len(payload) < 2:
        return b""
    nal_type = payload[0] & 0x1F
    out = b""
    if nal_type in range(1, 24):
        out = STREAM_START + payload
    elif nal_type == 28:
        fu_ind, fu_head = payload[0], payload[1]
        if fu_head & 0x80:
            nal = bytes([(fu_ind & 0xE0) | (fu_head & 0x1F)])
            out = STREAM_START + nal + payload[2:]
        else:
            out = payload[2:]
    elif nal_type == 24:
        p = payload[1:]
        while len(p) >= 2:
            sz = int.from_bytes(p[0:2], "big")
            p = p[2:]
            if len(p) < sz:
                break
            out += STREAM_START + p[:sz]
            p = p[sz:]
    return out


def new_conn():
    ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE
    ctx.load_cert_chain(CERT, KEY)
    s = socket.create_connection((RTSP_HOST, RTSP_PORT), timeout=8)
    t = ctx.wrap_socket(s, server_hostname=RTSP_HOST)
    t.settimeout(8)
    return t


def rtsp_send(t, method, url, hdrs):
    h = f"{method} {url} RTSP/1.0\r\nCSeq: {rtsp_send.seq}\r\n"
    for k, v in hdrs.items():
        h += f"{k}: {v}\r\n"
    h += "\r\n"
    rtsp_send.seq += 1
    t.sendall(h.encode())
    buf = b""
    while b"\r\n\r\n" not in buf:
        buf += t.recv(4096)
    return buf


def write_all(fd, data):
    while data:
        n = fd.write(data)
        if n is None:
            if not fd.writable():
                return False
            continue
        data = data[n:]
    return True


def stream_worker():
    while running:
        ffmpeg = None
        try:
            t = new_conn()
            rtsp_send.seq = 1
            rtsp_send(t, "OPTIONS", BASE, {"User-Agent": "stream_proxy"})
            r = rtsp_send(t, "DESCRIBE", BASE, {"Accept": "application/sdp"}).decode(errors="replace")
            trs = re.findall(r"a=control:(trackID=\d+)", r)
            if not trs:
                trs = re.findall(r"a=control:(\S+)", r)
            sess = None
            vid_chan = None
            for i, tr in enumerate(trs):
                inter = f"{i*2}-{i*2+1}"
                rr = rtsp_send(t, "SETUP", f"{BASE}/{tr}",
                               {"Transport": f"RTP/AVP/TCP;unicast;interleaved={inter}"}).decode(errors="replace")
                m = re.search(r"Session:\s*(\S+)", rr)
                if m:
                    sess = m.group(1).split(";")[0]
                m = re.search(r"Transport:.*interleaved=(\d+)", rr)
                if m and i == 0:
                    vid_chan = int(m.group(1))
            rtsp_send(t, "PLAY", BASE, {"Session": sess})
            print("[*] RTSP PLAY ok, video ch =", vid_chan)

            cmd = [FFMPEG, "-hide_banner", "-y", "-loglevel", "error",
                   "-f", "h264", "-i", "pipe:0",
                   "-c:v", "mjpeg", "-q:v", "4", "-f", "mjpeg", "pipe:1"]
            ffmpeg = subprocess.Popen(cmd, stdin=subprocess.PIPE,
                                      stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)

            def mjpeg_reader(proc):
                global latest_jpeg, frame_seq
                buf = b""
                while running:
                    chunk = proc.stdout.read(65536)
                    if not chunk:
                        break
                    buf += chunk
                    start = 0
                    while True:
                        s_ = buf.find(b"\xff\xd8", start)
                        e_ = buf.find(b"\xff\xd9", s_ + 2) if s_ >= 0 else -1
                        if s_ < 0 or e_ < 0:
                            if s_ > 0:
                                buf = buf[s_:]
                            break
                        jpg = buf[s_:e_ + 2]
                        buf = buf[e_ + 2:]
                        start = 0
                        with state_cond:
                            latest_jpeg = jpg
                            frame_seq += 1
                            state_cond.notify_all()

            th = threading.Thread(target=mjpeg_reader, args=(ffmpeg,), daemon=True)
            th.start()

            leftover = b""
            while running:
                if not leftover:
                    leftover = t.recv(65536)
                    if not leftover:
                        break
                if len(leftover) < 4:
                    leftover += t.recv(65536)
                    continue
                chan = leftover[1]
                plen = int.from_bytes(leftover[2:4], "big")
                if len(leftover) < 4 + plen:
                    leftover += t.recv(65536)
                    continue
                pkt = leftover[4:4 + plen]
                leftover = leftover[4 + plen:]
                if chan != (vid_chan or 0) or len(pkt) < 12:
                    continue
                if (pkt[1] & 0x7F) != 96:
                    continue
                data = depayload_h264(pkt[12:])
                if data and not write_all(ffmpeg.stdin, data):
                    break
        except (socket.timeout, ssl.SSLError, OSError) as e:
            print("[!] 拉流异常:", e)
        finally:
            try:
                if ffmpeg and ffmpeg.stdin:
                    ffmpeg.stdin.close()
            except Exception:
                pass
            try:
                t.close()
            except Exception:
                pass
            if running:
                print("[*] 3s 后重连...")
                time.sleep(3)


class Handler(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def log_message(self, *a):
        pass

    def do_GET(self):
        if self.path in ("/", "/index.html"):
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.end_headers()
            page = HTML_PAGE
            try:
                self.wfile.write(page.encode("utf-8"))
            except OSError:
                pass
            return
        if self.path == "/stream":
            self.send_response(200)
            self.send_header("Content-Type", "multipart/x-mixed-replace; boundary=frame")
            self.send_header("Cache-Control", "no-cache")
            self.send_header("Connection", "close")
            self.end_headers()
            last_sent = -1
            try:
                while running:
                    with state_cond:
                        if frame_seq != last_sent:
                            last_sent = frame_seq
                            data = latest_jpeg
                        else:
                            state_cond.wait(timeout=2.0)
                            continue
                    if data:
                        head = (b"--frame\r\nContent-Type: image/jpeg\r\n"
                                b"Content-Length: " + str(len(data)).encode() +
                                b"\r\n\r\n")
                        self.wfile.write(head + data + b"\r\n")
                        self.wfile.flush()
            except (BrokenPipeError, ConnectionResetError, OSError):
                pass
            return
        if self.path == "/snapshot.jpg":
            with state_cond:
                snap = latest_jpeg
            if not snap:
                self.send_response(503)
                self.end_headers()
                return
            self.send_response(200)
            self.send_header("Content-Type", "image/jpeg")
            self.send_header("Content-Length", str(len(snap)))
            self.send_header("Cache-Control", "no-cache")
            self.end_headers()
            try:
                self.wfile.write(snap)
            except OSError:
                pass
            return
        self.send_response(404)
        self.end_headers()

    def do_HEAD(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.end_headers()


HTML_PAGE = """<!doctype html><html><head><meta charset="utf-8"><title>BU 视频流代理</title>
<style>body{background:#111;color:#ddd;font-family:sans-serif;display:flex;flex-direction:column;align-items:center}
img{max-width:100%;border:1px solid #333;border-radius:8px}h1{font-weight:500;font-size:20px}
a{color:#7ab8ff;margin:8px}</style></head><body>
<h1>BU 摄像头实时画面</h1>
<img src="/stream" alt="live">
<p><a href="/snapshot.jpg">下载当前快照</a></p>
</body></html>"""


if __name__ == "__main__":
    th = threading.Thread(target=stream_worker, daemon=True)
    th.start()
    srv = ThreadingHTTPServer(("0.0.0.0", HTTP_PORT), Handler)
    print(f"[*] HTTP 服务已启动: http://0.0.0.0:{HTTP_PORT}  (Ctrl-C 停止)")
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        running = False
        srv.server_close()
        print("[*] 已停止")