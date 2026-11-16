import socket, ssl
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
s = socket.create_connection(("192.168.172.1", 554), timeout=6)
t = ctx.wrap_socket(s, server_hostname="192.168.172.1")
print("TLS cipher:", t.cipher())
req = ("OPTIONS rtsp://192.168.172.1:554/ch0 RTSP/1.0\r\n"
       "CSeq: 1\r\nUser-Agent: t\r\n\r\n")
t.sendall(req.encode())
t.settimeout(3)
buf = b""
try:
    while True:
        d = t.recv(4096)
        if not d: break
        buf += d
        if b"\r\n\r\n" in buf: break
except Exception as e:
    print("recv:", e)
print("----- raw response -----")
print(buf.decode(errors="replace"))
t.close()

