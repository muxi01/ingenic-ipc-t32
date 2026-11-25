#!/usr/bin/env python3
import struct

data = open('vmlinux.bin', 'rb').read()
base = 0x80010000
n = len(data) // 4
words = struct.unpack('<%dI' % n, data[:n * 4])

strs = {
    0x806b2de0: 'RSA Mod N verify failed',
    0x806b356a: 'Found root partition',
    0x806b36f8: 'verify_spl error.',
    0x806b370c: 'rootfs Signature is right!',
    0x806b3970: 'SPI NAND MTD LOAD OK',
    0x806b3988: 'SPI NAND rootfs verify failed!',
}

# 1) raw little-endian 32-bit values (KSEG0 and KSEG1)
print("=== raw LE 32-bit values ===")
for a, name in strs.items():
    for kseg in (a, a | 0x20000000):
        pat = struct.pack('<I', kseg)
        offs = []
        s = 0
        while True:
            idx = data.find(pat, s)
            if idx == -1:
                break
            offs.append(idx)
            s = idx + 1
        if offs:
            print('%-30s 0x%08x -> %s' % (name, kseg,
                  ['0x%08x' % (base + o) for o in offs[:8]]))

# 2) lui reg, 0x806b / 0xa06b (little-endian)
print("\n=== lui reg, 0x806b/0xa06b (LE) ===")
for idx, w in enumerate(words):
    if ((w >> 26) & 0x3f) == 0x0f and (w & 0xffff) in (0x806b, 0xa06b):
        print('  lui $%d,0x%04x @ 0x%08x  (word=0x%08x)'
              % ((w >> 16) & 0x1f, w & 0xffff, base + idx * 4, w))

# 3) addiu/ori reg, reg, <low16> (little-endian)
print("\n=== addiu/ori reg, reg, <low16> (LE) ===")
lows = {a & 0xffff: name for a, name in strs.items()}
for idx, w in enumerate(words):
    op = (w >> 26) & 0x3f
    if op in (0x09, 0x0d):  # addiu / ori
        imm = w & 0xffff
        if imm in lows:
            rs = (w >> 21) & 0x1f
            rt = (w >> 16) & 0x1f
            print('  %-30s imm=0x%04x -> $%d = $%d @ 0x%08x  op=%s'
                  % (lows[imm], imm, rt, rs, base + idx * 4,
                     'addiu' if op == 0x09 else 'ori'))