#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
把 vmlinux(ELF) 封装成 kernel.img (u-boot legacy uImage)，是 extract_vmlinux.py 的逆过程。

流程:
    vmlinux(ELF)  --提取原始二进制/加载地址/入口点-->  vmlinux.bin
    vmlinux.bin   --lzma 压缩 (LZMA_Alone 格式)-->   压缩数据
    压缩数据      --加 uImage 头 (含 CRC 校验)-->    kernel.img

用法:
    python3 build_kernel_img.py [vmlinux] [-o kernel.img]
    python3 build_kernel_img.py vmlinux.bin --load 0x80010000 --entry 0x80563E78

若输入是 ELF，则自动从 ELF 头中读取加载地址与入口点；
若输入是裸二进制 (如 vmlinux.bin)，需用 --load/--entry 指定。
"""

import argparse
import lzma
import os
import struct
import sys
import time
import zlib

# uImage 头相关常量
IH_MAGIC = 0x27051956
IH_HEADER_LEN = 64
IH_OS_LINUX = 5
IH_ARCH_MIPS = 5
IH_TYPE_KERNEL = 2
IH_COMP_LZMA = 3

# ELF 相关常量
EM_MIPS = 8
PT_LOAD = 1
ELFCLASS32 = 1


def crc32(data):
    """与 mkimage 一致的 IEEE 802.3 CRC32。"""
    return zlib.crc32(data) & 0xFFFFFFFF


def parse_elf(data):
    """从 ELF 中提取 (原始二进制, 加载地址, 入口点)。返回 None 表示不是 ELF。"""
    if data[:4] != b"\x7fELF":
        return None

    ei_class = data[4]
    ei_data = data[5]
    if ei_data == 1:
        endian = "<"
    elif ei_data == 2:
        endian = ">"
    else:
        raise ValueError("未知的 ELF 字节序: %d" % ei_data)

    if ei_class != ELFCLASS32:
        raise ValueError("仅支持 32 位 ELF")

    e_type, e_machine, e_version, e_entry, e_phoff, e_shoff, e_flags, \
        e_ehsize, e_phentsize, e_phnum, e_shentsize, e_shnum, e_shstrndx = \
        struct.unpack(endian + "HHIIIIIHHHHHH", data[16:52])

    if e_machine != EM_MIPS:
        raise ValueError("不是 MIPS ELF (e_machine=0x%x)" % e_machine)

    loads = []
    for i in range(e_phnum):
        off = e_phoff + i * e_phentsize
        p_type, p_offset, p_vaddr, p_paddr, p_filesz, p_memsz, p_flags, p_align = \
            struct.unpack(endian + "IIIIIIII", data[off:off + 32])
        if p_type == PT_LOAD:
            loads.append((p_vaddr, p_offset, p_filesz))

    if not loads:
        raise ValueError("ELF 中没有 PT_LOAD 段")

    loads.sort(key=lambda x: x[0])          # 按虚拟地址排序
    load = loads[0][0]                      # 加载地址 = 最低虚拟地址
    file_start = min(x[1] for x in loads)
    file_end = max(x[1] + x[2] for x in loads)
    raw = data[file_start:file_end]

    return raw, load, e_entry


def build_uimage(raw, load, entry, name, timestamp):
    """lzma 压缩并加 uImage 头，返回完整的 kernel.img 内容。"""
    # lzma 压缩 (LZMA_Alone 格式)，与原始镜像一致的参数: lc=3 lp=0 pb=2, 字典 64MB
    filters = [{
        "id": lzma.FILTER_LZMA1,
        "dict_size": 1 << 26,
        "lc": 3,
        "lp": 0,
        "pb": 2,
    }]
    payload = lzma.compress(raw, format=lzma.FORMAT_ALONE, filters=filters)

    name_bytes = name.encode("latin-1")[:32].ljust(32, b"\0")

    # 数据 CRC 必须先算，因为它要写进头部、并参与头部 CRC 的计算
    dcrc = crc32(payload)

    # 先构建头部：hcrc 占位为 0，dcrc 用真实值
    hdr = struct.pack(
        ">IIIIIIIBBBB32s",
        IH_MAGIC, 0, timestamp, len(payload), load, entry, dcrc,
        IH_OS_LINUX, IH_ARCH_MIPS, IH_TYPE_KERNEL, IH_COMP_LZMA,
        name_bytes,
    )

    # 头部 CRC: 计算时仅 hcrc 字段 (偏移 4..7) 置 0，其余 60 字节(含 dcrc)保持不变
    hdr_zeroed = hdr[:4] + b"\0\0\0\0" + hdr[8:]
    hcrc = crc32(hdr_zeroed)

    # 回填 hcrc
    hdr = struct.pack(
        ">IIIIIIIBBBB32s",
        IH_MAGIC, hcrc, timestamp, len(payload), load, entry, dcrc,
        IH_OS_LINUX, IH_ARCH_MIPS, IH_TYPE_KERNEL, IH_COMP_LZMA,
        name_bytes,
    )

    return hdr + payload


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    p = argparse.ArgumentParser(
        description="把 vmlinux(ELF) 封装成 kernel.img (u-boot legacy uImage)")
    p.add_argument("input", nargs="?", default=None,
                   help="输入文件 (默认: vmlinux，若不存在则用 vmlinux.bin)")
    p.add_argument("-o", "--output", default=os.path.join(script_dir, "kernel.img"),
                   help="输出文件 (默认: kernel.img)")
    p.add_argument("--load", default=None,
                   help="加载地址 (裸二进制输入时使用, 如 0x80010000)")
    p.add_argument("--entry", default=None,
                   help="入口点 (裸二进制输入时使用, 如 0x80563E78)")
    p.add_argument("--name", default="Linux-5.10.247-cip68",
                   help="uImage 名称字段 (默认: Linux-5.10.247-cip68)")
    p.add_argument("--timestamp", type=int, default=None,
                   help="uImage 时间戳 (默认: 当前时间)")
    p.add_argument("--pad-to", type=lambda x: int(x, 0), default=0,
                   help="输出文件补齐到 N 字节 (默认: 不补齐)")
    args = p.parse_args()

    # 确定输入文件
    if args.input:
        src = os.path.abspath(args.input)
    else:
        elf = os.path.join(script_dir, "vmlinux")
        raw = os.path.join(script_dir, "vmlinux.bin")
        src = elf if os.path.exists(elf) else raw

    if not os.path.exists(src):
        print("[错误] 找不到输入文件: %s" % src, file=sys.stderr)
        return 1

    with open(src, "rb") as f:
        data = f.read()

    # 解析输入
    parsed = parse_elf(data)
    if parsed is not None:
        raw, load, entry = parsed
        print("== 输入 ==")
        print("  类型      : ELF (MIPS)")
        print("  加载地址  : 0x%08X" % load)
        print("  入口点    : 0x%08X" % entry)
        print("  原始大小  : %d 字节" % len(raw))
    else:
        # 裸二进制输入
        load = int(args.load, 0) if args.load else 0x80010000
        entry = int(args.entry, 0) if args.entry else 0x80563E78
        raw = data
        print("== 输入 ==")
        print("  类型      : 裸二进制")
        print("  加载地址  : 0x%08X (可用 --load 指定)" % load)
        print("  入口点    : 0x%08X (可用 --entry 指定)" % entry)
        print("  原始大小  : %d 字节" % len(raw))

    timestamp = args.timestamp if args.timestamp is not None else int(time.time())

    img = build_uimage(raw, load, entry, args.name, timestamp)
    payload_size = len(img)

    if args.pad_to and len(img) < args.pad_to:
        img += b"\0" * (args.pad_to - len(img))

    out = os.path.abspath(args.output)
    with open(out, "wb") as f:
        f.write(img)

    print("\n== 输出 ==")
    print("  名称      : %s" % args.name)
    print("  时间戳    : %d" % timestamp)
    print("  压缩后    : %d 字节" % payload_size)
    print("  已写入    : %s (%d 字节)" % (out, len(img)))
    print("\n完成。可再用 extract_vmlinux.py 反向验证。")
    return 0


if __name__ == "__main__":
    sys.exit(main())