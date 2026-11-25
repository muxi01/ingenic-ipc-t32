#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
对 vmlinux.bin 打补丁：跳过 rootfs 的 RSA 签名校验。

背景:
    内核在 0x8033d950 (verify_spl / RSA 校验函数) 对 rootfs 做 RSA 签名校验，
    校验失败会依次打印:
        RSA Mod N verify failed
        verify_spl error.
        SPI NAND rootfs verify failed!
    然后拒绝挂载 rootfs。

原理:
    0x8033d950 返回 0=校验通过, 非0=校验失败。
    把它函数入口改成 "jr ra; li v0,0" (立即返回 0)，
    即可跳过整条校验链，让内核打印 "rootfs Signature is right!" 并正常挂载 rootfs。

补丁内容 (MIPS 小端, 文件偏移 = 虚拟地址 - 0x80010000):
    0x8033d950 -> 0x32d950: addiu sp,sp,-368 (90febd27) -> jr ra    (0800e003)
    0x8033d954 -> 0x32d954: sw s2,356(sp)     (6401b2af) -> li v0,0  (00000224)

用法:
    python3 patch_skip_rootfs_verify.py [vmlinux.bin] [-o vmlinux_patched.bin]
"""

import os
import sys


# 补丁表: {文件偏移: (原始字节, 补丁字节)}
PATCHES = {
    0x32D950: (bytes.fromhex("90febd27"), bytes.fromhex("0800e003")),  # addiu sp,sp,-368 -> jr ra
    0x32D954: (bytes.fromhex("6401b2af"), bytes.fromhex("00000224")),  # sw s2,356(sp) -> li v0,0
}


def patch(data, verbose=True):
    """应用补丁并校验，返回补丁后的数据。若原始字节不符则报错。"""
    for off, (orig, new) in sorted(PATCHES.items()):
        cur = data[off:off + 4]
        if cur != orig:
            raise ValueError(
                "偏移 0x%X 处原始字节不匹配: 期望 %s, 实际 %s (可能已打过补丁或文件版本不对)"
                % (off, orig.hex(), cur.hex()))
        data = data[:off] + new + data[off + 4:]
        if verbose:
            print("  [补丁] 0x%08X -> 文件偏移 0x%X: %s -> %s"
                  % (0x80010000 + off, off, orig.hex(), new.hex()))
    return data


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))

    argv = sys.argv[1:]
    out = os.path.join(script_dir, "vmlinux_patched.bin")
    src = os.path.join(script_dir, "vmlinux.bin")

    # 极简参数解析
    i = 0
    while i < len(argv):
        a = argv[i]
        if a in ("-o", "--output"):
            i += 1
            out = argv[i]
        elif a in ("-h", "--help"):
            print(__doc__)
            return 0
        else:
            src = a
        i += 1

    src = os.path.abspath(src)
    out = os.path.abspath(out)

    if not os.path.exists(src):
        print("[错误] 找不到输入文件: %s" % src, file=sys.stderr)
        return 1

    with open(src, "rb") as f:
        data = f.read()

    if len(data) <= max(PATCHES) + 4:
        print("[错误] 文件太小, 不是有效的 vmlinux.bin", file=sys.stderr)
        return 1

    print("== 输入 ==")
    print("  文件: %s (%d 字节)" % (src, len(data)))

    print("== 打补丁 ==")
    try:
        data = patch(data)
    except ValueError as e:
        print("[错误] %s" % e, file=sys.stderr)
        return 1

    # 写回 (不在原文件上改动，输出到新文件)
    with open(out, "wb") as f:
        f.write(data)

    # 打完补丁后验证
    print("== 验证 ==")
    with open(out, "rb") as f:
        f.seek(0x32D950)
        patched = f.read(8)
    assert patched == bytes.fromhex("0800e00300000224"), \
        "补丁写入验证失败: %s" % patched.hex()
    print("  0x32d950: jr ra      (0800e003)")
    print("  0x32d954: li v0,0    (00000224)")
    print("  验证通过")

    print("\n== 输出 ==")
    print("  %s" % out)
    print("\n下一步重新封装:")
    print("  python3 build_kernel_img.py %s --load 0x80010000 --entry 0x80563E78 -o kernel_patched.img"
          % out)
    return 0


if __name__ == "__main__":
    sys.exit(main())