#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
拆解君正 T32 的 kernel.img (u-boot legacy uImage)，得到 vmlinux 可执行程序。

kernel.img 结构:
    [0 .. 63]   u-boot legacy uImage 头 (64 字节)
    [64 .. ]    lzma 压缩的内核镜像 (原始 vmlinux.bin 的 lzma 数据)

输出:
    vmlinux.bin  解压出来的原始内核二进制 (raw, 加载地址 0x80010000)
    vmlinux      根据加载地址/入口点重建的 ELF 可执行文件 (MIPS 大端 32 位)

用法:
    python3 extract_vmlinux.py [kernel.img]
"""

import lzma
import os
import struct
import sys
import zlib

# uImage 头相关常量
IH_MAGIC = 0x27051956        # uImage 魔数
IH_HEADER_LEN = 64           # 头部长度
IH_COMP_LZMA = 3             # 压缩类型: lzma

# MIPS ELF 相关常量
ET_EXEC = 2
EM_MIPS = 8
PT_LOAD = 1
PF_R = 0x4
PF_W = 0x2
PF_X = 0x1
# MIPS32r2 + O32 ABI + noreorder + pic + cpic
EF_MIPS_FLAGS = 0x70001007


def crc32(data):
    """与 mkimage 一致的 IEEE 802.3 CRC32。"""
    return zlib.crc32(data) & 0xFFFFFFFF


def parse_uimage(data):
    """解析 uImage 头，返回字段字典。"""
    if len(data) < IH_HEADER_LEN:
        raise ValueError("文件过小，不是合法的 uImage")

    magic, hcrc, ts, size, load, entry, dcrc, os_, arch, typ, comp, name = \
        struct.unpack(">IIIIIIIBBBB32s", data[:IH_HEADER_LEN])

    if magic != IH_MAGIC:
        raise ValueError("魔数错误: 0x%08x (期望 0x%08x)，不是 uImage" % (magic, IH_MAGIC))

    name = name.split(b"\0")[0].decode("latin-1", "replace")

    # 校验头部 CRC (计算时头部 CRC 字段置 0)
    hdr = bytearray(data[:IH_HEADER_LEN])
    hdr[4:8] = b"\0\0\0\0"
    calc_hcrc = crc32(bytes(hdr))

    return {
        "magic": magic, "hcrc": hcrc, "calc_hcrc": calc_hcrc, "ts": ts,
        "size": size, "load": load, "entry": entry, "dcrc": dcrc,
        "os": os_, "arch": arch, "type": typ, "comp": comp, "name": name,
    }


def decompress(payload):
    """解压 lzma 数据 (LZMA_Alone 格式)。"""
    if payload[0] == 0x5D or True:
        # 使用 lzma 模块自动识别 LZMA_Alone 头
        pass
    return lzma.decompress(payload, format=lzma.FORMAT_ALONE)


def build_elf(raw, load, entry):
    """根据原始内核二进制重建 MIPS 大端 32 位 ELF 可执行文件。"""
    # ELF 头标识: 0x7fELF + 32位(1) + 大端(2) + 版本(1) + OSABI(0) + 8 个填充 0
    e_ident = b"\x7fELF" + bytes([1, 2, 1, 0]) + b"\x00" * 8

    # 一个 PT_LOAD 段覆盖整段原始镜像
    phnum = 1
    ehsize = 52
    phentsize = 32
    phoff = ehsize
    phdr_offset = phoff + phnum * phentsize

    ehdr = struct.pack(
        ">HHIIIIIHHHHHH",
        ET_EXEC,                 # e_type
        EM_MIPS,                 # e_machine
        1,                       # e_version
        entry,                   # e_entry
        phoff,                   # e_phoff
        0,                       # e_shoff
        EF_MIPS_FLAGS,           # e_flags
        ehsize,                  # e_ehsize
        phentsize,               # e_phentsize
        phnum,                   # e_phnum
        0,                       # e_shentsize
        0,                       # e_shnum
        0,                       # e_shstrndx
    )

    phdr = struct.pack(
        ">IIIIIIII",
        PT_LOAD,                 # p_type
        phdr_offset,             # p_offset
        load,                    # p_vaddr
        load,                    # p_paddr
        len(raw),                # p_filesz
        len(raw),                # p_memsz
        PF_R | PF_W | PF_X,      # p_flags (RWX)
        0x1000,                  # p_align
    )

    return e_ident + ehdr + phdr + raw


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    src = sys.argv[1] if len(sys.argv) > 1 else os.path.join(script_dir, "kernel.img")
    src = os.path.abspath(src)

    if not os.path.exists(src):
        print("[错误] 找不到文件: %s" % src, file=sys.stderr)
        return 1

    with open(src, "rb") as f:
        data = f.read()

    info = parse_uimage(data)
    print("== uImage 头 ==")
    print("  名称        : %s" % info["name"])
    print("  加载地址    : 0x%08X" % info["load"])
    print("  入口点      : 0x%08X" % info["entry"])
    print("  数据大小    : %d 字节" % info["size"])
    print("  压缩类型    : %d (%s)" % (info["comp"], "lzma" if info["comp"] == IH_COMP_LZMA else "未知"))
    print("  头部CRC     : 0x%08X (计算 0x%08X) %s" % (
        info["hcrc"], info["calc_hcrc"],
        "OK" if info["hcrc"] == info["calc_hcrc"] else "不匹配!"))

    # 取出压缩数据
    payload = data[IH_HEADER_LEN:IH_HEADER_LEN + info["size"]]
    print("  数据CRC     : 0x%08X (计算 0x%08X) %s" % (
        info["dcrc"], crc32(payload),
        "OK" if info["dcrc"] == crc32(payload) else "不匹配!"))

    if info["comp"] != IH_COMP_LZMA:
        print("[警告] 压缩类型不是 lzma(%d)，仍尝试按 lzma 解压" % IH_COMP_LZMA, file=sys.stderr)

    # 解压
    raw = decompress(payload)
    print("\n== 解压结果 ==")
    print("  原始内核大小: %d 字节 (0x%X)" % (len(raw), len(raw)))

    # 输出文件
    out_bin = os.path.join(script_dir, "vmlinux.bin")
    out_elf = os.path.join(script_dir, "vmlinux")
    with open(out_bin, "wb") as f:
        f.write(raw)
    elf = build_elf(raw, info["load"], info["entry"])
    with open(out_elf, "wb") as f:
        f.write(elf)

    print("  已写入       : %s" % out_bin)
    print("  已写入       : %s (ELF, %d 字节)" % (out_elf, len(elf)))
    print("\n完成。可用 readelf/objdump/gdb 分析 vmlinux。")
    return 0


if __name__ == "__main__":
    sys.exit(main())