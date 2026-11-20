# IPC 摄像头 bu_app RTSP 视频流逆向获取全记录

> 目标设备：Philips Avent Baby Monitor（BU/摄像头）
> SoC：君正 Ingenic T33（`isvp_t33`）
> 二进制：`bu_app.bin`（ELF 32-bit MIPS MIPS32 rel2, dynamically linked, stripped）
> 反汇编：`bu_app.asm`（约 45 万行）
> 本文档记录从端口分析 → 汇编定位 → TLS/mTLS → 证书解密 → 成功取流 的完整过程与关键点。

---

## 1. 目标确认与端口分析

设备运行 `bu_app`，`netstat` 显示监听端口：

```
tcp  0.0.0.0:5001  LISTEN  bu_app
tcp  0.0.0.0:554   LISTEN  bu_app   ← RTSP 端口
tcp  0.0.0.0:6000  LISTEN  bu_app
tcp  0.0.0.0:8090  LISTEN  bu_app   ← HTTP 维护后台
```

RTSP 标准端口为 554。

---

## 2. 汇编定位 `rtsp_listen_thread`

**关键认识**：二进制是 stripped 的，`rtsp_listen_thread` 是静态函数，无符号。objdump 会把没有标签的代码归属到其前一个导出符号名之下，因此它在反汇编中显示为 `rtspServer2_check_send_timeout@@Base+0x...`。

### 定位方法（由函数调用链反推）
1. 直接搜 `rtsp_listen_thread` → 无结果（符号被剥离）；
2. 转而搜 RTSP 相关导出符号（`rtspServer_*`）与 nl-lib 网络 API（`nl_socket_*`、`nl_thread_create`）；
3. 用 `nl_socket_accept` + `nl_thread_create` 模式匹配出 accept 循环。

### 关键地址
| 项 | 地址 / 位置 | 说明 |
|----|------------|------|
| **RTSP 监听/accept 线程** | `0x57085c`（asm L341033） | select 循环 + `nl_socket_accept`(0x570a98) + `nl_thread_create` |
| **每客户端会话线程** | `0x56ed50`（L339294） | `rtspServer_client_init` → 循环 `tcp_recv`/parse → `rtspServer_client_release` |
| **RTSP 服务初始化** | `0x56e678`（L338854） | 建 socket → bind 554 → listen → 创建监听线程 |
| **核心处理** | `rtsp_parse_request` 0x56b91c、`rtspServer_send_response` 0x56d1e8、`find_stream_from_uri` 0x56cd94 | 请求解析 / 响应 / 按 URI 找流 |

---

## 3. 从二进制提取 RTSP 关键事实（strings）

对 `bu_app.bin` 提取字符串，锁定关键信息：

| 项目 | 值 | 证据字符串 |
|------|-----|-----------|
| **URL 格式** | `rtsp://<IP>:554/ch0` | `rtsp://%s:%d/ch0` |
| **视频 track0** | H.264 pt96 / H.265 pt97，90000 | `a=rtpmap:96 H264/90000`、`a=rtpmap:97 H265/90000` |
| **音频 track1** | AAC (MP4A-LATM)，RTCP/AVP pt98 | `a=fmtp:...mode=AAC-hbr;sizelength=13...` |
| **Server 标识** | `nlsdk` | `Server: nlsdk` |
| **方法集** | OPTIONS/DESCRIBE/SETUP/TEARDOWN/PLAY | `Public: ...` |
| **RTP 传输** | 仅 RTPAVPTCP（interleaved/TCP） | `SSL only RTPAVPTCP`、`bu_tcp_recv/send`、`audioRecv_tcp_recv` |
| **鉴权** | HTTP Digest(MD5)，用户 `admin` | `NlDigestCalcHA1/Response`、`auth fail: ...` |
| **Web/配对** | 密码由父设备(PU)屏幕动态显示 | `Check your Parent Unit display...`、`/config/pair_info.json` |

---

## 4. 首次连接真相：RTSP 走 TLS

针对 `rtsp://192.168.172.1:554/ch0` 发 OPTIONS，设备打印：

```
[INFO] rtsp_listen_thread: accept client(192.168.172.2:35358)
[ERROR] rtsp_listen_thread TLS handshake failed: ...wrong version number
```

**结论**：端口后直接是 TLS 握手，需改用 **`rtsps://`**（ffmpeg 的 RTSP demuxer 不支持 TLS，此路不通，改用脚本/socat）。

---

## 5. 突破 mTLS（双向证书认证）

python ssl 客户端握手结果：

```
TLS cipher: TLS_AES_256_GCM_SHA384, TLSv1.3, 256
recv: TLSV13_ALERT_CERTIFICATE_REQUIRED   ← 服务器强制要求客户端证书
```

**关键点**：TLS 握手本身成功，但要求客户端证书 —— 即 **mTLS**。证书并非出厂静态，而是设备用 OpenSSL 动态生成，且证书文件是加密存储的。

相关符号：
```
BU_App_Decrypt_cert_file
/config/cert/ca_cert.pem  /config/cert/cam_cert.pem  /config/cert/cam_key.pem
/tmp/cert/ca_cert.pem /tmp/cert/cam_cert.pem /tmp/cert/cam_key.pem   ← 解密后落盘路径
mkdir -p /tmp/cert / build "/config/cert
X509_REQ_new / X509_REQ_set_pubkey / X509_REQ_sign / PEM_write_bio_X509_REQ
SSL_CTX_set_verify / SSL_CTX_use_certificate_file / SSL_CTX_use_PrivateKey_file
```

### 5.1 解密算法逆向

设备上的证书文件（`ca_cert.pem`/`cam_cert.pem`/`cam_key.pem`）与 `pair_info.json` 均为密文，且：

- 全部长度为 **16 的整数倍** → AES 块加密；
- `ca_cert` 与 `cam_cert` 的**前 16 字节完全相同** → 相同明文首块 → **确定性加密，IV 全 0**；
- 四份文件共享同一把 AES-128 key。

**逆向到的加解密包装函数**（一对，结构相同）：
- 加密函数 `0x4359a4`
- 解密函数 `0x435af8`
- 签名：`(mode, key=a0, iv=a1, data=a3, len=a2, out=stack[88])`
  - `mode==1` → AES-128-**CBC**；否则 → AES-128-**CTR**
  - **IV = 16 个 0x00**（调用点在栈上 `sw zero` 五次清零）
  - `EVP_DecryptInit/Update/Final`（对应用 `EVP_aes_128_cbc` / `EVP_aes_128_ctr`）

**证书解密函数** `BU_App_Decrypt_cert_file` @ `0x438d08`：
- `system("mkdir -p /tmp/cert")` 等建目录清理；
- 对三个硬编码路径分别调用解密函数 `0x438ad4(src, dst, key)`，解密后写到 `/tmp/cert/*.pem`；
- 证书 key 来自调用方传入的结构体字段指针（`.bss` 地址 `0x679985`，运行时派生，非静态串）。

### 5.2 避开 key 的取巧路径

`.bss` 里的 key 是运行时算出来的，离线逆向成本高。**捷径**：解密函数会把证书明文写到 `/tmp/cert/`，设备运行时文件系统里就有明文。直接拷贝设备上的 `/tmp/cert/*.pem` 即得明文证书。

> mTLS 校验需要一张由设备 CA 签发的客户端证书。**用设备自己的 `cam_cert.pem` + `cam_key.pem` 作客户端身份即可通过校验**（设备即自身 CA，接受自己的证书为合法客户端身份）。

---

## 6. 完整取流验证

用明文证书做客户端 TLS 身份，python 手写 RTSP 会话：

```
TLS OK: (TLS_AES_256_GCM_SHA384, TLSv1.3, 256)
== OPTIONS ==   RTSP/1.0 200 OK
== DESCRIBE ==  RTSP/1.0 200 OK   (无 401：不强制 Digest)
== SETUP video trackID ==  200   interleaved 通道
== PLAY ==  RTSP/1.0 200 OK
→ 持续收到 interleaved H264(PT96) / AAC(PT98) RTP 帧
```

**结论**：该固件对 `/ch0` 的读取**不强制 Digest 鉴权**，`admin` 密码无关紧要。成功拿到实时视频流。

---

## 7. 最终成果与工具

| 工具 | 文件名 | 功能 |
|------|--------|------|
| 实时监控流 | `pull_stream.py` | mTLS 会话 + 打印 RTP 帧结构 |
| 录像 | `save_stream.py` | 录制 `*.h264` / `*.aac` 元素流 |
| **抓图** | `snapshot.py` | 一键存 `*.jpg`（已验证出图） |

**已验证可用命令**：
```bash
# 抓图
python3 snapshot.py snapshot.jpg

# 录视频
python3 save_stream.py stream 15
ffmpeg -y -f h264 -i stream.h264 -c copy video.mp4
```

**取流核心参数**：
- `rtsps://192.168.172.1:554/ch0`
- 客户端身份：`cam_cert.pem` + `cam_key.pem`（跳过证书校验 `verify_mode=CERT_NONE`）
- Transport：`RTP/AVP/TCP;unicast;interleaved=<低>-<高>`（通道号以 SETUP 返回为准）
- 视频 `PT=96`（H.264），音频 `PT=98`（AAC-LATM）

---

## 8. 关键技术要点总结（速查）

1. **符号剥离下的定位**：静态函数无符号，用「导出符号 + 网络 API 调用模式」反推目标线程/函数。
2. **`.rodata` 字符串是金矿**：`strings` 一下就能拿到 URL 格式、SDP、realm、路径等关键事实。
3. **TLS 判断**：连接后 `wrong version number` 说明等的是 TLS；`TLSV13_ALERT_CERTIFICATE_REQUIRED` 说明是 mTLS。
4. **自签证书的高速漏洞路径**：旧相机 mTLS 直接用「设备自有的证书即合法客户端身份」，越过了「必须由 CA 单独签发客户端证书」的假设。
5. **加密文件不必拆 key**：解密函数会落盘明文，直接抓运行时的明文比逆向 key 来源省力。
6. **RTSP over TCP interleaved**：信令与媒体复用同一连接，脚本一次建会话即可流式接收。

---

## 9. 合规提醒

本记录涉及的能力（绕过 mTLS 客户端证书校验、无鉴权读取视频）仅应在**自有设备/已获授权**的前提下进行逆向与测试。请勿用于访问未经授权的第三方设备。

---

## 10. 视频编码参数逆向（分辨率 / 帧率 / 码率）

> 本节目标：确认当前版本 `bu_app.bin` 的 RTSP 视频流分辨率与帧率从哪来，是否可调整。
> 结论：**当前版本已移除老版本的 JSON 配置入口，视频编码参数为硬编码默认值；分辨率/帧率可通过补丁二进制修改。**

### 10.1 与老版本配置对比

| 项 | 老版本 `bu_config.json` | 当前版本 `config/bu_config.json` |
|----|------------------------|--------------------------------|
| `media.video.enc` | **存在**（width/height/fps/bitrate/gop/rc_mode/profile/codec） | **不存在** |
| 保留项 | media/ctrl/event/rtsp/talkback/wakeup 等全量 | 仅 lullaby/talkback/alert/wifi |
| 视频参数来源 | 配置文件可调 | **硬编码** |

### 10.2 关键逆向证据

1. **rodata 精确扫描**（前 16 字节对齐定位，确认无带引号 JSON 键）：
   当前版本在 `.rodata` 中**不存在**以下键：`"video"/"enc"/"fps"/"width"/"height"/"bitrate"/"gop"/"rc_mode"/"profile"/"codec"/"media"/"isp"`。
2. **保留的动态接口**（仅 QoS 自适应，非用户可配）：
   `PAL_Video_EncoderSetFps`、`PAL_Video_EncoderSetBitrate`、`BU_Media_SetVideoFps`、`BU_Media_SetVideoBitrate`；
   rodata 配置键 `video_fps`/`video_bitrate` 紧随 `qos_version`（Wi-Fi 网络自适应，只能动态微调码率/帧率，**不能改分辨率**）。
3. **硬编码默认值函数**：`0x436c00`（默认配置结构体初始化），一次写入全部参数。

### 10.3 硬编码默认值定位（0x436c00 函数）

| 代码地址 | 指令 | 原始立即数 | 写入结构体偏移 | 含义 |
|----------|------|-----------|---------------|------|
| `0x436c38` | `li a0,864` | 864 | +36 | 编码宽度 |
| `0x436c40` | `li a0,480` | 480 | +40 | 编码高度 |
| `0x436c48` | `li a0,1200` | 1200 | +56 | 码率 (kbps) |
| `0x436c50` | `li a0,1280` | 1280 | +72 | 备用宽度 |
| `0x436c58` | `li a0,720` | 720 | +76 | 备用高度 |
| `0x436c68` | `li v1,20` | 20 | +0 / +44 / +60 | fps（及同源 gop 等） |
| `0x436cfc/0x436c28` | `li a3,6000` / `li a0,128` | 6000 / 128 | +820 / +4..16 | 端口 / ISP 参数 |

> 注意：`0x436c68` 的 `v1=20` 被多次 `sw` 写入偏移 +0/+44/+60，这表明三者当前同值（fps、gop 等），补丁帧率时三者会同步变化，请按需核对。

### 10.4 可调整性结论

- ❌ **通过 `config/bu_config.json` 改分辨率/帧率**：不可行（JSON 键已移除）。
- ✅ **补丁二进制硬编码默认值**：可行、最直接。改 `0x436c38/0x436c40`（宽高）与 `0x436c68`（fps）、`0x436c48`（码率）。
- ⚠️ **对齐约束**：编码宽度需 **16 对齐**、高度需 **2 对齐**（固件内 `width must be aligned with 16, height must be aligned with 2`）。
- ⚠️ **双流痕迹**：存在备用 1280x720（+72/+76），固件可能支持更高分辨率，但以主流 SDP 返回为准。

有关打补丁的可执行脚本见工程内 `patch_buapp.py`。

---

## 11. 视频参数补丁操作（patch_buapp.py）

```bash
python3 patch_buapp.py --width 1280 --height 720 --fps 25 --bitrate 1600
```
- 默认输入 `bu_app.bin`，输出 `bu_app.bin_patched`（输出名 = 输入名 + `_patched`），**绝不改写原文件**。
- 未指定的维度保持原值（宽 864 / 高 480 / fps 20 / 码率 1200）。
- 脚本自动做 **宽度 16 对齐**、**高度 2 对齐** 校验；并带三重保护（输出与输入同路径拒绝、输出已存在拒绝覆盖）。
- 打补丁后按工程刷机流程重新部署 `bu_app` 并重启即可生效。

### 11.1 实测验证结论（BU 端实机运行）

使用下列参数补丁并刷入 BU 固件：

| 参数 | 原值 | 补丁值 | 结果 |
|------|------|--------|------|
| width | 864 | 1280 | ✅ |
| height | 480 | 720 | ✅ |
| fps | 20 | 25 | ✅ |
| bitrate | 1200 | 1600 | ✅ |

**实机运行一切正常**：固件正常引导、编码参数生效，补丁仅改动 4 条 `addiu` 立即数（全文件 2528868 字节中仅 7 字节差异），指令格式与寄存器字段未破坏，已验证可行。

---

## 12. 视频参数补丁的复现与校验（patch_buapp.py 输出核对）

- 校验原文件未被改动：`sha256sum` 对比 `bu_app.bin`（`f7d7ffc9...`）与 `bu_app.bin_patched`（`d4ec9398...`）应不同。
- 字节级差异核对：`cmp -l bu_app.bin bu_app.bin_patched | wc -l` 应为 **7**（宽 2 字节 + 高 2 字节 + 码率 2 字节 + 帧率 1 字节）。
- 差异位置映射（file off → VA）：
  - `0x36c38-0x36c39` → `0x436c38` width
  - `0x36c40-0x36c41` → `0x436c40` height
  - `0x36c48-0x36c49` → `0x436c48` bitrate
  - `0x36c68`         → `0x436c68` fps

---

## 13. 合规提醒（补充）

修改固件会改变设备行为，请仅在自有设备与已授权前提下进行；打补丁前务必备份原始 `bu_app.bin`（脚本默认不覆盖原文件，输出 `_patched` 文件）。