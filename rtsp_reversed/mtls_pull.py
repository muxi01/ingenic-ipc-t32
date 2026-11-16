import socket, ssl
ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_CLIENT)
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
ctx.load_cert_chain("config/plain_cert/cam_cert.pem", "config/plain_cert/cam_key.pem")
s = socket.create_connection(("192.168.172.1", 554), timeout=6)
t = ctx.wrap_socket(s, server_hostname="192.168.172.1")
print("Handshake OK, cipher:", t.cipher())
t.sendall(b"OPTIONS rtsp://192.168.172.1:554/ch0 RTSP/1.0\r\nCSeq: 1\r\n\r\n")
print(t.recv(2048))

