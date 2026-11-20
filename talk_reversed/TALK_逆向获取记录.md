# BU 端 talkback（语音上传/对讲播放）逆向获取记录

> 目标设备：Philips Avent Baby Monitor（BU/摄像头）
> SoC：君正 Ingenic T33（`isvp_t33`）
> 二进制：`bu_app.bin`（ELF 32-bit MIPS，动态链接，已剥离符号）
> 反汇编：`bu_app.asm`（约 45 万行）
> 目标：PC 端向 BU 端上传语音流 → BU 端播放（talkback 能力）
> 本文档记录 talkback 服务的完整逆向：默认配置 → 服务初始化 → TCP 服务器 → 会话线程 → RTP 解析 → 播放回调 → 音频引擎。

---

## 1. 背景与结论速览

**配置变迁**：
- 旧版本 `old_version/config/bu_config.json` 存在完整 talkback 配置：
  `"talkback": {"port": 12345, "volume": 60, "mute": 0, "gain": 26, "enable_ssl": 1}`
- 当前版本 `config/bu_config.json` 仅保留 `talkback.volume`，其余参数**硬编码**进二进制。

**结论（已确认）**：
| 项 | 值 |
|----|-----|
| 服务端口 | **12345**（硬编码） |
| 传输协议 | **TLS / mTLS**（与 RTSP 取流相同的双向证书认证） |
| 帧封装 | **RTSP interleaved 帧**：`$` + 通道号(1B) + 大端长度(2B) + 媒体数据 |
| 媒体封装 | **RTP 包**（标准 12 字节头，payload 即音频数据） |
| 音频格式 | 上传 payload 为 **G.711（`codec` 0=µ-law / 1=A-law），640B/帧（40ms@16kHz）**；BU 解码后为 **PCM S16LE / 单声道 / 16kHz，1280B/帧**（见第 10 节） |
| 连接数 | 单客户端（新客户端接入将先关闭旧连接） |

**完整链路**：
```
JSON 解析/配置默认值(0x436c00, talkback块在偏移+0x420)
  → 服务创建 0x431ae8(svc, cfg, 后置回调0x442560, ctx)
      ├─ 音频引擎  0x428ba8(svcobj+64, param{...})          ← 最终写入硬件
      ├─ 格式转换  0x426528(svcobj+68, {1,16000,type,640})  ← type!=2 时启用
      └─ TCP 服务  0x57d390(svcobj+60, cmd, 播放回调0x4317e0, svcobj)
          └─ 监听线程 bbm_audioRecvThread  @0x57cddc
              └─ 客户端会话线程 bbm_audioRecvClientThread @0x57c664
                  └─ TCP收流 audioRecv_tcp_recv @0x57c118 (支持SSL)
                      └─ RTP解析 audioRecv_rtp_audio_out @0x57c3f0
                          └─ 播放回调 @0x4317e0 → 音频引擎写入
```

**双服务架构（talkback 的"点火开关"）**：
- **6000 端口配置服务**：开机即监听（TLS/mTLS），私有帧协议 `magic"PIXI"+type(16)+len(32)+body(JSON)+CRC16(poly 0xa001)`，业务回调 = `0x443980`（cJSON 配置分派大函数）。向它下发含 `samplerate`/`frame_len` 的 JSON 即触发 talkback 服务创建。
- **12345 端口 talkback 服务**：**默认不创建**（`0x4457c0` 服务槽为空时才调 `0x431ae8` 创建），需经 6000 端口配置帧"点火"。详见 8.2 节。

---

## 2. 硬编码默认配置（0x436c00 函数 · talkback 块）

`0x436c00` 是全局默认配置初始化函数（视频参数也在这里，见 RTSP 记录 10.3 节）。
talkback 配置区 `cfg1` 位于 **服务对象 + 0x420 (1056)**。

talkback 相关汇编证据（服务对象基址 s0）：

```
436da0/436da4:  li v0,49(then 48)/25 → +0x430(cfg1+16)=48, +0x438(cfg1+24)=25
436de0:  li v1,12345 ; 436dec: sh v1,1056(s0)   → cfg1+0 = port = 12345 (u16)
436df0:  sw s5,1060(s0)                          → cfg1+4 = 16000   (s5=0x3e80)
436df8:  sw s4,1068(s0)                          → cfg1+12 = 640    (s4=0x280)
436dfc:  sw s1,1084(s0)                          → cfg1+28 = 1   (s1=1, SSL开关)
436e00:  sw s1,1088(s0)                          → cfg1+32 = 1
436e14/18/1c: sw zero,1048/1036/1040(s0)
436e20:  sw zero,1064(s0)                        → cfg1+8  = 0   (格式 type)
436e24:  sw zero,1076(s0)                        → cfg1+20 = 0   (mute?)
436e3c:  addiu s3,s0,1108 → 证书路径缓冲1
436e80:  addiu s2,s0,1236 → 证书路径缓冲2
436e98:  addiu s1,s0,1364 → 证书路径缓冲3
436efc/436f00/436f04: sw s3/s2/s1, 1092/1096/1100(s0)
            → cfg1+36/+40/+44 = 指向三份证书路径缓冲
```

> **证书路径默认值（已用 strings 确认）**：三份缓冲分别 strncpy 自 rodata
> `0x5df5ac` → **`/tmp/cert/ca_cert.pem`**
> `0x5df5c4` → **`/tmp/cert/cam_cert.pem`**
> `0x5df5dc` → **`/tmp/cert/cam_key.pem`**
> 即 talkback 服务直接用**解密后落盘于 /tmp/cert 的明文证书**（与 RTSP 记录第 5 节
> `BU_App_Decrypt_cert_file` 解密写入 `/tmp/cert/` 完全一致）。
>
> 高效对照方法（本固件）：**VA = strings 文件偏移 + 0x400000**；
> 如 strings `1df5ac` → VA `0x5df5ac`。另有 33 字节字符串自 `0x5dcd4c` 写入 s0+1522（证书目录相关命令串，暂不关键）。

**cfg1 结构（52 字节，端口起）**：

| 偏移 | 默认值 | 含义 |
|------|--------|------|
| cfg1+0  | **12345** (u16) | 监听端口 |
| cfg1+4  | 16000 | 采样率（**已确认** = 16kHz，WAV 交叉验证一致） |
| cfg1+8  | 0 | 编码 codec（**0=G.711 µ-law，1=G.711 A-law**；均 8bit→16bit 解码，输入 640B→输出 1280B，见第 10 节） |
| cfg1+12 | 640 | 每帧样本数（**已确认**：解码输出 1280B = 40ms@16kHz 单声道 S16LE） |
| cfg1+16 | 48 | **volume（已确认，见 2.1 节）**，范围 [-30,60]，JSON 键 `"volume"` |
| cfg1+20 | 0 | **mute**（伴随 volume 一并写引擎 engine+20，默认 0） |
| cfg1+24 | 25 | engine+24 构造参数（未在二进制发现独立 JSON 键，疑似 gain/AGC） |
| cfg1+28 | 1 | **enable_ssl** |
| cfg1+32 | 1 | SSL 守卫（非零继续） |
| cfg1+36 | 证书缓冲1 | CA 文件路径 |
| cfg1+40 | 证书缓冲2 | 客户端证书路径 |
| cfg1+44 | 证书缓冲3 | 客户端私钥路径（`/tmp/cert/cam_key.pem`） |

### 2.1 JSON 解析写入点（volume）——已完全定位

关键字符串：`"volume"` file 0x1df604 → **VA 0x5df604**（`lui 0x5e` + `addiu -2556`）。

汇编链条（执行顺序）：

```
443c18: lui   s6, 0x5e
443c1c: addiu a1, s6, -2556        ; a1 = "volume" (0x5df604)
443c20: jal   4402ac (cJSON_GetObjectItem)
443c20→  a0 = s3                    ; 配置 JSON 根对象 → GetObjectItem(s3, "volume")
443c2c: li    v1, 8                 ; cJSON_Number
443c34: beq   a0, v1, 4445b0        ; ★类型为数字 → 进入音量处理块
4445b0: lw    a1, 20(v0)            ; a1 = value.number
4445b4: addiu v0, a1, 30
4445b8: sltiu v0, v0, 91            ; 范围校验：a1 ∈ [-30, 60]
4445bc: beqz  v0, 444ad8            ; 越界 → 拒绝
4445c4: lw    a0, 2184(s4)          ; a0 = talkback 服务对象 (svc)
4445c8: beqz  a0, 443dfc            ; 服务未创建则跳过
4445cc: sw    a1, 1072(s4)          ; ★ cfg1+16 = volume        （130+ 对应 0x430=0x420+16)
4445d0: jal   431ee0                ; ★ 应用音量
4445d4: lw    a2, 1076(s4)          ;   a2 = cfg1+20 (mute)
```

**431ee0(a0=svc, a1=volume, a2=cfg1+20)** 实现（音量热更新入口）：

```
431ee8: beqz  a0 → 失败
431ef0: lw    a0, 64(a0)  ; engine = svc+64（音频引擎句柄）
431ef4: beqz  engine → 失败
431efc: jal   42921c      ; a1/a2 原样透传
```

**42921c(engine, volume, mute)**（引擎参数写入）：

```
42925c: sw    s1, 16(s0)  ; engine+16 = volume
429260: sw    s2, 20(s0)  ; engine+20 = mute
429264: 4baa60 / 4bac8c / 4ba8fc  ; 引擎内部队列锁 + 参数应用
```

**反向证据**（上报路径）：`443cdc-443cf8` 将 `lwc1 f0,1072(s4)` 以键 **"volume"** 打包进输出 JSON
（`440d48(s0, "volume", (double)1072(s4), ...)`），再次证明 1072(s4) == `cfg1+16` 就是音量字段。

**旁证**：当前 `bu_config.json` 的 `"talkback":{"volume":48}` 与硬编码默认 48 完全一致
（配置键缺失即回落默认）；旧版本 `"volume": 60` 在合法范围 [-30,60] 上界。

> ⚠️ 注意：0x444580 段曾因键名 `"pu_progress"`（0x1e2368→VA 0x5e2368）被误判为音量写入点；
> 实锤其数字分支跳往 `444864`（OTA 升级进度上报），**不会**到达 4445b0/4445cc。
> 4445b0 的唯一入口是 "volume" 键的 443c34 分支。

---

## 3. 服务对象创建（0x431ae8）

签名：`0x431ae8(svc, cfg=svc+0x420, postcb=0x442560, ctx=svc)`

流程：
1. `calloc(80)` → `svcobj`；把 **cfg1 前 52 字节** 原样拷入 `svcobj+0..51`（lwl/lwr 循环）。
2. `svcobj+52 = 0x442560`（后置回调）、`svcobj+56 = ctx`。
3. `malloc(12(svcobj)<<1)` → `svcobj+72` = **1280B 解码输出缓冲**。
4. `0x428ba8(svcobj+64, {1, second(cfg1+4), third(cfg1+12), 2, cfg1+16, cfg1+20, cfg1+24})`
   → 创建**音频引擎**，句柄存 `svcobj+64`。
5. 若 `cfg1+8(type) != 2`：
   `0x426528(svcobj+68, {1, cfg1+4(16000), cfg1+8(type), cfg1+12(640)})`
   → 创建**格式转换对象**，句柄存 `svcobj+68`。
6. `0x57d390(svcobj+60, cmd[24B], 播放回调=0x4317e0, ctx=svcobj)` → 启动 TCP 服务。

**svcobj 布局**：`+8`type `+12`每帧样本数 `+52`后置回调 `+56`ctx `+60`(recv对象基点) `+64`引擎 `+68`转换对象 `+72`解码缓冲。

---

## 4. TCP 服务（0x57d390 初始化 / 0x57cddc 监听 / 0x57c664 会话）

### 4.1 初始化 0x57d390(`base`, cmd, 播放回调, ctx)
- `calloc(128,1)` → recv 对象；若 `base≠0` 则先复制 base 内容（返回对象内嵌于 svcobj+60 语义）。
- 输入 cmd 结构（调用点组装，sp+24 起）：
  | 偏移 | 值 | 含义 |
  |------|----|------|
  | +0  | cfg1+0 (12345, u16) | 端口 |
  | +8  | cfg1+4 (16000) | 采样率 |
  | +12 | magic (1001/1003/1004，按 type 选择) | 引擎类型 |
  | +16 | cfg1+12 (640) | 每帧样本数 |
  | +20 | cfg1+28 (1) | SSL 开关 |
  | +24 | cfg1+32 (1) | SSL 守卫 |
  | +28/+32/+36 | cfg1+36/40/44 | CA / 证书 / 私钥路径 |
- `rate = 640 * 1000 / 16000 = 40`（存 recv 对象 +108，作为抖动/超时基准）。
- `socket(AF_INET, SOCK_STREAM)` +(recv对象+52)，`bind(port=12345)`，`listen(32)`。
- 若 `cmd+20(SSL) != 0`：
  - `SSL_CTX_new(TLS)`；(recv对象+64) = ctx
  - `SSL_CTX_set_verify(mode=3)` ← **mTLS**（VERIFY_PEER|FAIL_IF_NO_PEER_CERT）
  - `set_ca_file(cmd+28)` / `use_cert(cmd+32)` / `use_key(cmd+36)` → 校验结果非零才继续
  - 创建监听线程 `bbm_audioRecvThread`（参数：a0=recv对象+120, a3=recv对象）。

### 4.1.1 调用链与双模式修正（2026-11-20）

**调用链精确定位**（纠正此前的调用方定位）：

```
0x431ae8 (服务创建) ──JAL 0x431d88──► 桩 0x423900 ──► 0x57d390 (init)
```

- `0x423900` 是链接器生成的 **PIC 跳板桩**（`.text` 段起始 `0x4237c0` 起的 16B stub）：
  `lui t9,0x58; j 0x57d390; addiu t9,t9,-11376; nop`（t9 = 0x580000-0x2C70 = 0x57d390）。
- 扫描「谁引用桩 0x423900」→ 唯一调用方 `0x431d88`（位于 0x431ae8 内部）。
- 因此直接扫「谁跳 0x57d390」只能命中桩本身的 `j` 指令，必须扫桩地址才能找到真正调用方。

**socket/bind/listen 双分支**（重新逐字节反汇编，纠正旧 4.1 的「无条件 TCP」）：

| 条件 (cmd 字段) | socket | bind(12345) | listen | 线程路径 |
|------|--------|------|--------|----------|
| `cmd+4==0 && cmd+20==0` | SOCK_STREAM(TCP) | ✅ | ❌ | recvfrom → `audioRecv_rtp_audio_out` |
| `cmd+4!=0 \|\| cmd+20!=0` | SOCK_DGRAM(UDP) | ❌ | ✅ (backlog 待核实) | accept → 子线程 → `audioRecv_tcp_recv` |

证据链：`0x57d51c lw v0,4(s1)` → `bnez`；`0x57d52c lw v0,20(s1)` → `beqz`；
TCP 分支 `0x57d83c li a1,1`(SOCK_STREAM)，UDP 分支 `0x57d540 li a1,2`(SOCK_DGRAM)。

**待解疑点（下一步反汇编 0x431ae8 组装 cmd 的代码）**：
1. `cmd+4` 语义：旧 cmd 表中无此字段，疑似「传输模式」(0=TCP 直连，非零=UDP)。
2. `cmd+20` 语义：旧记录记为 SSL 开关(cfg1+28=1)。若为真，则「SSL开→UDP」与常规 TLS(需 TCP) 矛盾，除非实为 DTLS 或字段极性相反。
3. listen backlog 旧记录载 32，本次重读疑似 1024，需核实。

**「12345 未监听」解释**：若 talkback 实际走 TCP 分支（cmd+4==0 && cmd+20==0），则 socket 仅 bind 到 12345 而从不 listen，`netstat -an` 自然无 LISTEN 状态，与实机现象一致；但「bind 而不 listen、走 recvfrom」仍需结合调用方实际赋值才能自洽（如是否另有 connect/accept 路径）。

### 4.2 监听线程 bbm_audioRecvThread @0x57cddc
- 循环 read：recv对象+52=listen fd、+64=SSL ctx、+76=阻塞标记。
- accept 到客户端：打印 IP:port → 若 recv对象+120 非空（已有客户端）则**先关闭旧连接再处理新连接**（单客户端模型）。
- 记录：recv对象+56=新 fd、+68=SSL*、+116=0；+100=200(ms)；初始化 jitter 记录（+84, +104, +108）。
- 创建会话线程 `bbm_audioRecvClientThread`。

### 4.3 客户端会话线程 bbm_audioRecvClientThread @0x57c664
严格 interleaved 帧解析（与 RTSP 取流相同封装），**逐字节证据**：

```
57c734-57c73c: 首字节必须 == 0x24 ('$')，bne → 57c970 打日志后结束会话线程
57c744-57c750: 读第 2 字节 → 通道号，仅 57c764 打日志，不校验值
57c77c-57c790: 读 2 字节 → u16 长度
57c7ac:       wsbh 交换字节序 → 大端长度
57c7c8-57c7cc: sltiu v0,s1,2049 → 长度 < 2049（≤2048），超长跳 57ca14 结束会话
57c7d4-57c7e8: 读 len 字节入缓冲 (recv对象+60 指向的堆缓冲) → audioRecv_rtp_audio_out
```
- 读数据统一走 `audioRecv_tcp_recv @0x57c118`：`(fd, SSL*)` 两个句柄二选一，循环收满指定长度。
- 抖动/超距判定（57c804-57c850、57c958）：仅更新遥测字段 +100/+104，**不中断会话**。
- 帧循环：57c8ec-57c8f4 记录时间戳后回到 57c710 读下一帧；recv对象+116 非零则退线程。

---

## 5. RTP 解析（audioRecv_rtp_audio_out @0x57c3f0）

逐字节证据（57c44c-57c538）：
- `57c450-57c454`：RTP 头 word0 的 **bit4（扩展位 X）置位 → 拒收**，返回 -1（不影响会话）。
- `57c460-57c47c`：word0 低 4 位 = CSRC 计数 → 头长度 = 12 + CSRC×4；payload = 总长 − 头长。
- `57c494-57c4c0`：序列号（word2 高 2 字节，大端）≠ 上次+1 时**仅打日志**，不拒收。
- RTP 版本/填充位无强校验；理论需满足 RTSP 常规规范（v=2, 无填充）。
- 播放回调调用点：
  ```
  57c56c: lw  t9, 44(s4)   ; 播放回调函数指针 (recv对象+44 = 0x4317e0)
  57c578: lw  a0, 48(s4)   ; 回调上下文     (recv对象+48 = svcobj)
  57c574: move a1, s0      ; RTP payload 数据指针
  57c584: jalr t9          ; 调用播放回调
  57c588: move a2, s1      ; payload 长度
  ```
- 即：**`0x4317e0(svcobj, rtp_payload, payload_len)`**，除 RTP 头外无额外封装
  （回调还收到 sp+16/20 的时间刻度形参，播放侧不使用）。

---

## 6. 播放回调 @0x4317e0（核心消费路径）

签名 `(ctx=svcobj, data, len)`：
```
type = svcobj+8
if type == 2 → 直通：跳过转换，直接构造 {data,len} 写引擎
else（默认 type=0）:
    out = { ptr=svcobj+72(1280B缓冲), bytes=svcobj+12*2=1280 }
    ret = 0x42679c(转换对象 svcobj+68, in={data,len}, out)
写引擎（无论 type）:
    0x429318(engine, &state)           ← 引擎状态查询
    0x4291c4(engine, &framedata, 1)    ← 向引擎队列写一帧
收尾:
    if svcobj+52(0x442560) != 0 → 0x442560(svcobj+56, 0, 0)   ← 后置回调
```

### 转换函数 0x42679c(convobj, in, out)
- `convobj+8 == 3` → **特殊压缩解码路径**：`(data[0], data[2..3] 组合头)` → `0x4296d8(data+4, len-4, out)` 解码为 16bit 样本（out 容量按其 4 倍上限校验）。
- 否则（默认 type=0）→ **队列直通**：`4be5b4(convobj+16, in, 0)` put → `4be920(convobj+16, &blk)` get → `memcpy(out, blk)` → `4bea8c(convobj+16)` commit。即默认模式不改变字节流。

> 由第 4/5/6 节可得 **期待 PC 侧发送的媒体内容 = 裸音频数据（convobj 默认直通，RTP payload 对外只校验头）**；
> 具体编码由音频引擎内部决定，见第 7 节。

---

## 7. 音频引擎（0x428ba8 与内部构造）

### 7.1 引擎创建 0x428ba8(engine_slot, param[7])
调用点传入参数（32 字节，逐字段写入 `engine+0..31`）：

| 参数 | 值 | 来源/含义 |
|------|-----|----------|
| +0  | **1** | 引擎格式标志（常量） |
| +4  | 16000 | cfg1+4（采样率） |
| +8  | 640  | cfg1+12（每帧样本数，驱动内部解码分支选择） |
| +12 | **2** | 常量 |
| +16 | 48   | **volume（已确认）**：cfg1+16，可经 `42921c` 热更新（2.1 节） |
| +20 | 0    | **mute**：cfg1+20，随 volume 一并写入（42925c/429260） |
| +24 | 25   | cfg1+24，仅构造期生效，语义未定（疑似 gain/AGC） |

- `engine+0..31 = param` 原样拷贝；`engine+40/+44` = 内部队列句柄。
- 内部由若干子构造逐步搭建（4b85e4 → 4b87b8 → 4b8884 → 4b8bc8），具体写硬件路径待深入。
- 写帧 API：`0x4291c4(engine, framedata, 1)`、状态查询 `0x429318(engine, &state)`。

### 7.2 特殊解码器 0x4296d8（engine/conv 配置 type==3 时调用）
- 签名 `0x4296d8(data, len, out)`，从 `s1=0x6648e0`（全局结构，+8 = 设备索引）取设备号。
- 内部对**字符设备节点**做多次 `open/write/close`（write 内容来自 rodata 常量 0x60539c/0x6075ac/0x62ac84 等），随后回传结果，疑似**君正硬件音频编解码加速**控制接口。
- 该路径仅在 `type==3` 配置出现，当前默认 `type=0` 不触发；但它是识别「设备支持的压缩编码清单」的钥匙。

---

## 8. 与 RTSP 取流可复用的成熟结论（交叉引用 RTSP_逆向获取记录.md）

1. **mTLS 客户端身份**：直接用设备自己的 `cam_cert.pem + cam_key.pem`（`config/plain_cert/` 已有明文）作客户端身份，
   `verify_mode=CERT_NONE` 即可通过——talkback 服务端 `verify_mode=3` 结构与 RTSP 完全一致。
2. **协议封装**：interleaved 帧结构与 RTSP 取流共用一套 `audioRecv_tcp_recv`（0x57c118）逻辑。
3. **证书路径**：talkback 默认三份证书路径**已确认**为 `/tmp/cert/{ca_cert,cam_cert,cam_key}.pem`
   （rodata `0x5df5ac/0x5df5c4/0x5df5dc`，即运行时解密后的明文证书）；
   客户端身份仍用设备自带 `cam_cert.pem/cam_key.pem`（`config/plain_cert/`）。
4. **信令后播放**：RTSP 取流通道音频为 AAC-LATM（PT98）；talkback 通道独立（12345/TLS），直接 RTP 承载裸音频，
   编码格式与引擎参数强相关（16kHz、40ms/帧、640 样本）。

---

## 8.1 音频格式交叉验证（BU 自带 lullaby 样本）

`audio/` 下 6 个 wav（1_Baa Baa Black Sheep … 6_White Noise，均从 BU 提取、格式完全统一）：

```
$ file audio/*.wav
RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, mono 16000 Hz   （×6）

$ ffprobe …
codec_name=pcm_s16le / sample_rate=16000 / channels=1 / bits_per_sample=16   （×6）
```

**与 talkback 引擎参数一一对应**：`cfg1+4=16000`（采样率）、`cfg1+12=640`（每帧样本数 →
解码输出 640×2=1280B = 40ms@16kHz 单声道 PCM16）。lullaby 与 talkback 共用同一音频引擎，
故 **PC 侧应发送 PCM S16LE 单声道 16kHz 数据，单 RTP payload 建议 = 1280B（40ms）或其整数倍**。

---

## 8.2 控制/配置服务（TLS **6000** 端口）与私有帧协议 —— talkback 的"点火开关"

> 实机 `--probe` 结论：12345 端口在未下发配置前**不监听**（Connection refused）。
> 与之相对，**6000 端口配置服务在 BU 开机时即创建并监听**，且它就是触发 talkback 服务创建的入口。
> 本小节锁定：6000 服务如何创建（0x432ed0）→ 其私有帧协议 → 配置回调（0x443980）→ talkback 服务创建点（0x4459bc）。

### 8.2.1 全局对象与两服务的相对布局（对象基址 0x679118）

由 `0x436c00`（默认配置初始化）与 main 调用点（424af4..424b08）共同确定：

| 偏移 | 地址 | 内容 |
|------|------|------|
| +820 (0x334) | 0x67944c | **配置服务配置块**：+0 = 端口 u16 = **6000**（436c00 写入） |
| +1056 (0x420) | 0x679538 | **talkback 配置块 cfg1**：+0 = 端口 u16 = **12345**（见第 2 节） |
| +2184 (0x888) | 0x679920 | **talkback 服务槽**（为空 → 创建 12345 服务，见 8.2.4） |
| +2216 (0x8a8) | 0x6799c0 | 配置服务槽（`432ed0` 将服务对象写入此槽） |

三个 `432ed0` 调用点（配置服务，回调全部 = 0x443980）：

| 调用点 | a0(服务槽) | a1(配置块) | a2(回调) | a3(全局) | 场景 |
|--------|-----------|-----------|----------|----------|------|
| `424b08`(main) | 0x6799c0 | 0x67944c | 0x443980 | 0x679118 | 开机无条件创建 |
| `42d918` | s0+2216 | s0+820 | 0x443980 | s0 | 上报/订阅刷新路径 |
| `43bc10`(网络主循环) | s0+2216 | s0+820 | 0x443980 | s0 | 网络主循环按需重建 |

→ **6000 端口配置服务开机即监听、回调恒为 0x443980，无需任何外部触发。**

### 8.2.2 通用 TLS 服务创建器 0x432ed0(svc 槽, cfg 块, 回调, 全局)

`0x432ed0` 是配置服务与 talkback 通用的服务创建器（talkback 在上层 0x431ae8 另行包装，见第 3 节）。

- 参数：`a0=服务槽指针`（成功后将对象首地址写回）、`a1=配置块`、`a2=业务回调`、`a3=全局`。
- `calloc(76)` 服务对象；cfg 块前 28 字节（**00 00 4c** 布局）原样拷入对象头；
  **对象+28 = 回调(a2)**、**对象+32 = 全局(a3)**（`ae330020/ae35001c`）。
- `malloc(2048)×2` → **对象+52 / +56 两个收发缓冲**。
- `socket(AF_INET,SOCK_STREAM)` → 对象+36；`setsockopt(SO_REUSEADDR)`；
  `lhu 端口=0(cfg块)` + `wsbh`（大端）→ `bind(0.0.0.0:端口)`；`listen(5)`。
- TLS（条件 `4(cfg块)`≠0，`8(cfg块)`=1 时 `verify=3`=mTLS）：
  `TLS_server_method`→`SSL_CTX_new`(对象+44)；`set_verify`(0 或 3)；
  `load_verify_locations`(12(cfg)=CA) / `use_cert`(16(cfg)) / `use_PrivateKey`(20(cfg))；
  任一失败打印错误码并清理。
- `pthread_create(&全局+68, 0x431f60, 全局)` 启动 accept 线程；成功后 `服务对象首地址 → 0(svc槽)`。

**cfg 块布局（通用，28 字节）**：
| 偏移 | 内容 |
|------|------|
| +0  | 端口 u16 |
| +4  | SSL 使能（6000 配置服务默认 =1） |
| +8  | verify 开关（=1 时 set_verify(3)=mTLS） |
| +12 | CA 证书路径 |
| +16 | 服务器证书路径 |
| +20 | 服务器私钥路径 |

（注：talkback 服务的 TCP 监听来自 `0x431ae8` → `0x57d390`（另见第 3 节/第 4.1 节 cmd 结构），
是否同样由 0x432ed0 家族承载 —— 待后续对 0x431ae8/0x57d390 逐级展开确认；不排除与
配置服务复用同模板。）

### 8.2.3 连接/会话线程与私有帧协议（0x431f60 → 0x432960）

- `0x431f60`（accept 线程，pthread 入口）：`accept` → 若对象+44(SSL ctx)≠0 → `SSL_new/SSL_set_fd/SSL_accept`（非阻塞+select 超时重试）；
  成功后把 client fd、SSL* 存回 **对象+40/+48**，再 `pthread_create(&对象+72, 0x432960, 对象)` 起连接处理线程。
  TLS 握手失败走 ERR 日志分支（含 `ERR_error_string`）。
- `0x432960`（连接处理线程，**协议骨架**）：
  - **帧魔法字**：`lw s3,-6548(s0)`（0x5e0000-0x1994 = **0x5de66c** → 文件偏移 `1de66c`）
    = ASCII **"PIXI"**（`50 49 58 49`）；先`recv`4字节逐字节比对，不匹配直接结束。
  - 帧头 12 字节（偏移 0..11 紧跟 magic 之后，即**整帧 0 基址下 4..15**）：
    `+4`=word0 BE16 / `+6`=**type BE16** / `+8`=**len BE32** / `+12`=保留 BE32；
    `len < 2049` 校验，超限拒收。
  - body：再读 `len-16` 字节到 `帧+16`（头部共 16 字节），末尾补 `\0` 截断 → C 字符串（JSON）。
  - **CRC16 校验帧尾**：`init=0xffff`、`poly=0xa001`（LSB 位驱动、低阶反射）——即 CRC-16/BU 私有实现；
    对**整帧前 len-2 字节**计算，与帧尾 2 字节（BE）比对，不符拒收。
  - 调用业务回调：
    ```
    432bb8:   lw a0, 32(s6)    ; a0 = 对象+32 = 全局
    432bc4:   addiu a1, sp,52  ; a1 = 帧结构（52(sp) 起，含 6()=type、16()=body）
    432bb8→   addiu a2, sp,24  ; a2 = 输出结构（回调返回后用于组装响应帧）
    jalr 28(s6)                ; ★ 业务回调 = 0x443980（配置大函数）
    ```
  - 回调返回后组装**响应帧**：恰好 16 字节头 + 输出数据，写回 对象+56 缓冲并发送，随后回到 `PIXI` 重试读下一帧。

**私有帧协议汇总（发送方视角，向 6000 端口发送）**：
```
[0..3]   "PIXI"            （魔法）
[4..5]   word0  BE16        （业务无关，响应原样回显；可填 0）
[6..7]   type   BE16        （0..18，跳转表 0x5e2540 分派；talkback 配置 = 11）
[8..11]  len    BE32        （= 16 + body_len + 2）
[12..15] 保留   BE32        （可填 0）
[16..]   body    (len-16)字节，即 JSON 字符串
[末尾2]  CRC16  BE（poly 0xa001 init 0xffff，覆盖前 len-2 字节）
```
请求也走 **TLS(6000)**（与 RTSP 同款 mTLS 证书可通）。

### 8.2.4 配置回调 0x443980 与 talkback 服务创建触发链

`0x443980` 栈帧 464 字节；入口参数 `(a0=全局, a1=帧结构, a2=输出结构)`：
- `s2=a1`：`96460006 lhu type,6(s2)` → `type ∈ {1,14}` 仅决定是否打印提示，**并非硬门槛**；
  真正分派走 **跳转表 0x5e2540（19 项，type 0..18）**。
- `8e440010 lw a0,16(s2)` → `cJSON_Parse`(body)（0x440080）；失败打印 `cJSON_GetErrorPtr` 并返回。
- 分派：`443a30 lhu type` → `443a34 sltiu(v0,type,19)` type≥19 报错；否则 `443a4c lw v0,跳转表[type]` → `443a50 jr v0`。

**跳转表（VA 0x5e2540，19 项，节选）**：
| type | handler | 语义 |
|------|---------|------|
| 1  | 0x444438 | 设备信息（model/version/sn/mac/ip/utc_time） |
| 11 | **0x44433c** | **talkback 服务配置（enable/codec/samplerate/frame_len）** |
| 14 | 0x443e1c | 配置响应上报 |

> 此前误判 type=1 即 talkback：type=1 实为设备信息处理器，其首个必需键为 `model`，
> 故发送 `{"samplerate":...}` 时报 `json(model) err`。talkback 的正确 type 为 **11**。

**talkback 服务创建触发链（type=11）**：
```
44433c: GetObjectItem(json, "enable")        ← 键 0x5da714（必需, number, {0,1}）
44434c: beqz → 443c44 json(enable) err
4444b8: lw v0,20(v0) ; sltiu(v0,2)           ← enable∈{0,1}
444ae4: beqz v0,444d1c                       ★ enable==0 → 销毁 talkback
   │ enable==1：
444af0: GetObjectItem(json, "volume")        ← 键 0x5df604（可选, number）
444b20: GetObjectItem(json, "codec")         ← 键 0x5e1ec0（必需, number, 0=G.711 µ-law / 1=G.711 A-law）
4450f4: GetObjectItem(json, "samplerate")    ← 键 0x5e1ed0（必需, number, [8000,16000]）
445694: sw v1, 1060(s4)                      ★ cfg1+4  = samplerate
44569c: GetObjectItem(json, "frame_len")     ← 键 0x5e1eec（必需, number, <2049）
445718: sw v0, 1068(s4)                      ★ cfg1+12 = frame_len（每帧样本数）
445710: pthread_mutex_lock(&s4+3308)
   │
4457c0: lw a0, 2184(s4)                      ← talkback 服务槽
4457c0: beqz → 4459bc                        ★ 槽空 → 创建
   │
4459bc: lui a2,0x44 ; addiu a2,a2,9568       ; a2 = 0x442560（后置回调）
4459c8: addiu a1,s4,1056                     ; a1 = s4+1056 = cfg1（12345 端口块）
4459cc: jal 431ae8                           ★ 创建 talkback 服务
4459d0: addiu a0,s4,2184                     ; a0 = &s4+2184 = 服务槽
```
即 **`0x431ae8(svc=&s4+2184, cfg=s4+1056, postcb=0x442560, ctx=s4)`** 与第 3 节签名完全一致。

**实机触发最小报文（type=11）**：
```json
{"enable": 1, "codec": 0, "samplerate": 16000, "frame_len": 640}
```
> 键校验规则：`enable`∈{0,1}（1=创建，0=销毁）；`codec` 取值 0=G.711 µ-law / 1=G.711 A-law（二者均为 8bit→16bit 解码，输入 640B→输出 1280B，见第 10 节）；
> `samplerate`∈[8000,16000]；`frame_len`<2049（640 样本=40ms@16kHz，即 1280B/帧）；
> `volume`∈[-30,60]（可选，缺省走默认分支）。
> 上述均为**平铺键**（非嵌套 talkback 子对象）——6000 端口私有帧即"通用控制信令"，
> 与 `bu_config.json` 的嵌套结构是两套格式。

**旁证（网络主循环 + 命令分派）**：`0x43b4b0` 网络主循环还在 `0x43bc08` 再次调用 `432ed0`
（同 0x443980 回调、同 820 配置块），其帧分派器 `0x439124` 支持 cmdid 0~211 共 40+ 类命令——
配置服务与通用控制帧存在复用关系；6000 端口私有帧即"通用控制信令"的一环。

---

## 9. 下一步待办

- [x] 提取 `bu_app.bin` rodata 证书路径字符串 → **`/tmp/cert/{ca_cert,cam_cert,cam_key}.pem`**（strings `1df5ac` 等，见第 2 节）。
- [x] 确认音频引擎期望的**编码格式** → **PCM S16LE 单声道 16kHz，40ms/帧（1280B）**（已由 `audio/*.wav` 交叉验证，见 8.1 节）。
- [x] 定位 JSON 解析对 `volume` 的写入点 → 键 `"volume"`(0x5df604) → 443c34 → **4445b0÷4445cc 写 cfg1+16** → 431ee0 → 42921c（engine+16）；范围 [-30,60]，与当前配置 48 吻合（见 2.1 节）。
- [x] 确认 12345 端口为何未监听 → **talkback 服务需经 6000 端口配置帧触发创建**（见 8.2.4）。
- [x] 完整解析 6000 端口私有帧协议 → **magic "PIXI" + type(16) + len(32) + body(JSON) + CRC16**（见 8.2.3）。
- [x] 明确 cfg1+24=25（engine+24）语义 → **gain（音频增益，默认 25）**，由实机日志 `Audio Out GetGain gain:25` 坐实；`volume` 缺省默认 48。
- [x] 编写 6000 端口**配置触发脚本** `trigger_talkback.py`：mTLS 连接 192.168.172.1:6000 → 组装 PIXI 帧（**type=11**, JSON `{"enable":1,"codec":0,"samplerate":16000,"frame_len":640}` + CRC16）→ **实机验证通过**：BU 日志 `msgId 0xb` → `BU_talkback_init+` → `PAL_Audio_InitializePlayback`（16kHz/bitwidth16/chnCnt1/numPerFrm640）→ 响应 `code:0, port:12345`。
- [x] **实机验证 type=11 触发成功，但 12345 仍未监听** → `netstat -an` 仅有 5001/554/6000/23 在 LISTEN，**无 12345**。BU 日志 `BU_talkback_init+…-` + `bbm_audioRecvThread+` 已跑通（PAL_Audio 引擎 16kHz/bitwidth16/chnCnt1/numPerFrm640 + 解码器 + `nl_audioRecv_init` + `shm_init`），响应 `code:0, port:12345`。**待查**：`0x431ae8`/`0x57d390` 是否真的 `socket/bind/listen`（还是音频走 netlink/shm 而非 TCP）；端口常量 `0x436de0`(cfg1+0=12345) 是否落在 type=11 触发链上被写入。
- [x] 编写/完善 PC 端上传脚本 `upload_talkback.py`：TLS(mTLS) 连接 12345 → interleaved 帧（`$`+通道+BE长度<2049）→ RTP（X=0）→ payload=**G.711 编码后 640B/帧**（`--codec ulaw/alaw`，默认 `ulaw` 与 trigger 默认 `codec:0` 对齐；内置标准 A-law/µ-law 编码器）。
- [x] 实机验证完整链路：6000 触发 → 12345 监听 → 上传 G.711 µ-law 音频 → BU 播放（实机可闻 440Hz 提示音，无 `stream->len to big` 告警，见第 10 节）。

---

## 10. 最终总结（端到端打通）

### 10.1 目标达成
PC 端向 BU 端上传语音流并播放的完整链路已**实机打通**：

```
6000 端口触发(type=11) → 创建 12345 talkback 服务
  → PC mTLS 连接 12345 → interleaved 帧 → RTP → G.711 µ-law 640B/帧
  → BU G.711 解码(8bit→16bit, ×2) → 1280B S16LE → PAL_Audio 播放
```

### 10.2 关键结论（最终定版）

| 项 | 结论 |
|----|------|
| 触发方式 | 6000 端口私有帧 **PIXI + type=11**，JSON `{"enable":1,"codec":0,"samplerate":16000,"frame_len":640}` |
| 服务端口 | **12345**（mTLS，双向证书） |
| 音频编码 | **G.711**，`codec` 0=µ-law / 1=A-law（`0x426528` 分支 → `0x5045f0`/`0x504564` 两个解码器） |
| 输入帧 | **640 字节 G.711**/帧（40ms@16kHz） |
| 解码输出 | **1280 字节** S16LE 单声道（8bit→16bit ×2 扩展） |
| 块大小校验 | `0x4b755c`：bitwidth=16 → numPerFrm×2=640×2=1280，**无 PCM 直通路径** |

> 修正历史：此前误判 `codec:0` 为 PCM 直通，实为 µ-law 解码；误判 `codec:3` 为压缩路径。
> 最终确认 codec 0/1 分别对应 µ-law/A-law G.711 解码器，二者均为 8bit→16bit 扩展。

### 10.3 交付脚本

- [trigger_talkback.py](./talk_reverse/trigger_talkback.py)：6000 端口 PIXI 触发，默认 `codec:0`(µ-law)。
- [upload_talkback.py](./talk_reverse/upload_talkback.py)：G.711 音频上传，`--codec ulaw/alaw`（默认 `ulaw`）、`--tone`/`--file`、`--fast` 等选项，内置标准 G.711 编码器（静音/满幅校验点已通过：µ-law 0→0xff、+32767→0x80、-32768→0x00；A-law 0→0xd5、+32767→0xaa、-32768→0x2a）。

### 10.4 实机验证记录

```
$ python3 trigger_talkback.py
response: word0=0x0000 type=11 len=147 crc=0x5422
body: {"enable":1,"volume":30,"port":12345,"codec":0,"samplerate":16000,"frame_len":640,"code":0,"reason":""}

$ python3 upload_talkback.py --tone --duration 3 --fast
connected, sending 75 G.711 ulaw frames (640 bytes each) ...
done, 75 frames in 0.00s
```

- 75 帧 × 640 样本 = 48000 样本 = 3.0s @16kHz，与 `--duration 3` 精确匹配。
- BU 端可闻 440Hz 提示音；收尾日志为干净释放序列（`close_client_socket` → `bbm_audioRecvThread-` → `nl_audioRecv_release` → `BU_talkback_release` → `PAL_Audio_ReleasePlayback/ReleaseDecoder`）。
- 全程无 `stream->len 2560 to big` 告警。

### 10.5 运维注意

- **D 状态卡死**：实机曾出现 bu_app 进程进入 `D`（不可中断睡眠）+ 僵尸进程 `Z`，导致 6000 端口 TLS 握手超时。D 状态进程无法 `kill`，只能**整机重启**；仅重启 bu_app 无效。
- **证书路径**：mTLS 证书位于 BU 的 `/tmp/cert/{ca_cert,cam_cert,cam_key}.pem`（易失目录），整机重启可能清空，需确认是否由启动脚本自动生成。
- **编码对齐**：上传端 `--codec` 必须与触发端 `codec` 一致（默认均 `ulaw`/`0`），否则解码长度不匹配。

---

## 11. 合规提醒
talkback 为设备自带对讲/播放功能，PC 上传语音仅应在**自有设备与已获授权**的前提下进行。请勿用于未授权场景。