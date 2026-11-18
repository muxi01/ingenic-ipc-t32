#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
patch_buapp.py —— 修改 bu_app.bin 中硬编码的 RTSP 视频编码参数。

背景：
    当前版本 bu_app.bin 已移除老版本 bu_config.json 的 media.video.enc 配置入口，
    视频参数（宽度/高度/帧率/码率）硬编码在函数 0x436c00 内的 addiu 立即数中。
    通过对固件的像素对齐约束 "width 16-align / height 2-align" 补丁这些立即数，
    即可调整 RTSP 视频流参数，无需改配置文件。

参数写回点（addiu rt,$zero,imm 指令，rt 见下表）：
    VA 0x436c38  li a0,864   -> +36  编码宽度        (rt=4)
    VA 0x436c40  li a0,480   -> +40  编码高度        (rt=4)
    VA 0x436c48  li a0,1200  -> +56  码率 (kbps)     (rt=4)
    VA 0x436c68  li v1,20    -> +0/+44/+60  fps 等   (rt=3)

说明：
    * fileoff = VA - 0x400000（.text VA 0x4237c0 对 file off 0x237c0）
    * addiu rt,$zero,imm 编码：0x24000000 | (rt<<16) | (imm & 0xffff)
    * 宽度必须 16 对齐，高度必须 2 对齐，否则报错退出。
    * 输出名 = 输入名 + "_patched"，不会改写原文件。
    * bitrate 单位 kbps（千比特每秒），如 1600 表示 1.6 Mbps。
    * 默认（未指定参数）输出与输入一致，便于做纯备份。

常见用法（分辨率 / 帧率 / 码率）：

    # 1080p (1920x1080) @25fps / 3 Mbps
    python3 patch_buapp.py --width 1920 --height 1080 --fps 25 --bitrate 3000

    # 720p  (1280x720)  @25fps / 1.6 Mbps
    python3 patch_buapp.py --width 1280 --height 720  --fps 25 --bitrate 1600

    # 480p  (864x480)   @20fps / 1.2 Mbps（原厂等价参数）
    python3 patch_buapp.py --width 864  --height 480  --fps 20 --bitrate 1200
"""

import argparse
import os
import struct
import sys

__version__ = "1.0.0"

# (名称, VA, 默认值)
PATCH_SLOTS = {
    "width":  (0x436c38, 864),    # rt=4
    "height": (0x436c40, 480),    # rt=4
    "bitrate":(0x436c48, 1200),   # rt=4
    "fps":    (0x436c68, 20),     # rt=3
}

# rt 校验 (用于确认该地址确实是期望的目标寄存器)
SLOT_RT = {0x436c38: 4, 0x436c40: 4, 0x436c48: 4, 0x436c68: 3}

# 文本段偏移基准：fileoff = VA - 0x400000
VA_FILE_BASE = 0x400000


def load_ins(data, va):  # -> (op, rs, rt, imm)
    off = va - VA_FILE_BASE
    ins = struct.unpack_from("<I", data, off)[0]
    op = ins >> 26
    rs = (ins >> 21) & 0x1f
    rt = (ins >> 16) & 0x1f
    imm = ins & 0xffff
    if imm & 0x8000:
        imm -= 0x10000
    return op, rs, rt, imm, off


def valid_addiu(op, rs, rt):
    return op == 0x09 and rs == 0 and rt in (3, 4)


def patch_value(data, va, new_imm, expected_rt):
    op, rs, rt, old_imm, off = load_ins(data, va)
    if not valid_addiu(op, rs, rt) or rt != expected_rt:
        raise ValueError(
            f"VA {va:#x}: 目标地址并非 addiu rt,$zero 指令"
            f" (op={op} rs={rs} rt={rt}), 文件可能已被修改或基址不对。"
        )
    if not (0 <= new_imm <= 0x7fff):
        raise ValueError(f"VA {va:#x}: 立即数 {new_imm} 超出 addiu 正立即数范围 [0, 32767]。")
    nins = (0x24000000 | (rt << 16)) & 0xffffffff
    nins |= new_imm & 0xffff
    data[off:off + 4] = struct.pack("<I", nins)
    return old_imm


def main():
    ap = argparse.ArgumentParser(
        description="补丁 bu_app.bin 硬编码视频参数（默认输出与输入一致）。",
    )
    ap.add_argument("--input", default="bu_app.bin",
                    help="输入二进制（默认 bu_app.bin）")
    ap.add_argument("-o", "--output", default=None,
                    help="输出二进制（默认 {输入文件名}_patched）")
    ap.add_argument("--width", type=int, help="编码宽度（须 16 对齐）")
    ap.add_argument("--height", type=int, help="编码高度（须 2 对齐）")
    ap.add_argument("--fps", type=int, help="帧率")
    ap.add_argument("--bitrate", type=int, help="码率 (kbps)")
    args = ap.parse_args()

    if not os.path.exists(args.input):
        sys.exit(f"找不到输入文件: {args.input}")
    data = bytearray(open(args.input, "rb").read())

    # 默认输出名 = 源文件名 + "_patched"，绝不改写原二进制
    output = args.output if args.output else (args.input + "_patched")
    if os.path.abspath(output) == os.path.abspath(args.input):
        sys.exit(f"拒绝：输出路径 {output} 与输入相同，会覆盖原文件。")
    if os.path.exists(output):
        sys.exit(
            f"拒绝：输出文件 {output} 已存在，为避免覆盖旧补丁请先移除或改用 -o 指定其它路径。"
        )

    width = args.width if args.width is not None else PATCH_SLOTS["width"][1]
    height = args.height if args.height is not None else PATCH_SLOTS["height"][1]
    fps = args.fps if args.fps is not None else PATCH_SLOTS["fps"][1]
    bitrate = args.bitrate if args.bitrate is not None else PATCH_SLOTS["bitrate"][1]

    if width % 16 != 0:
        sys.exit(f"宽度 {width} 未 16 对齐（固件约束 width align 16）。")
    if height % 2 != 0:
        sys.exit(f"高度 {height} 未 2 对齐（固件约束 height align 2）。")

    desired = {"width": width, "height": height, "bitrate": bitrate, "fps": fps}
    print(f"输入 : {args.input} ({len(data)} bytes)")
    patched = False
    for name, (va, default) in PATCH_SLOTS.items():
        old = load_ins(data, va)[3]
        new = desired[name]
        if old == new:
            print(f"  - {name:7s} VA {va:#08x}: 保持 {old}")
            continue
        pold = patch_value(data, va, new, SLOT_RT[va])
        print(f"  * {name:7s} VA {va:#08x}: {pold} -> {new}")
        patched = True

    if not patched:
        print(f"无任何参数需要修改，原样写出: {output}")
    else:
        print(f"写出补丁后二进制: {output}")
    open(output, "wb").write(data)


if __name__ == "__main__":
    main()