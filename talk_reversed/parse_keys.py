import re

data = open('bu_app.bin','rb').read()
base_va = 0x400000

def rdstr(va):
    off = va - base_va
    if off < 0 or off >= len(data):
        return None
    end = data.index(b'\0', off)
    b = data[off:end]
    try:
        return b.decode('ascii')
    except Exception:
        return repr(b)

lines = open('cfg_full.asm').read().splitlines()
ins = []
for ln in lines:
    m = re.match(r'\s*([0-9a-f]+):\t[0-9a-f]{8}\s+(.*)', ln)
    if m:
        ins.append((int(m.group(1), 16), m.group(2)))

def walk_a1(i):
    """walk backward; two-pass: collect lui/li seeds, then replay addiu/move in order"""
    lo = max(0, i - 16)
    regs = {}
    for j in range(lo, i):
        _, t = ins[j]
        mm = re.fullmatch(r'\blui\s+(\w+),\s*0x([0-9a-f]+)', t)
        if mm:
            regs[mm.group(1)] = int(mm.group(2), 16) << 16
            continue
        mm = re.fullmatch(r'\bli\s+(\w+),\s*([-0-9]+)', t)
        if mm:
            regs[mm.group(1)] = int(mm.group(2))
    for j in range(lo, i):
        _, t = ins[j]
        mm = re.fullmatch(r'addiu\s+(\w+),\s*(\w+),\s*([-0-9]+)', t)
        if mm:
            dst, src, off = mm.group(1), mm.group(2), int(mm.group(3))
            sv = regs.get(src)
            regs[dst] = None if sv is None else sv + off
            continue
        mm = re.fullmatch(r'move\s+(\w+),\s*(\w+)', t)
        if mm:
            regs[mm.group(1)] = regs.get(mm.group(2))
    return regs.get('a1')

for i, (addr, txt) in enumerate(ins):
    m = re.search(r'jal\s+([0-9a-f]+)', txt)
    if not (m and int(m.group(1), 16) == 0x4402ac):
        continue
    key_va = walk_a1(i)
    if key_va and 0x5d0000 <= key_va < 0x600000:
        print('0x%08x: cJSON_GetObjectItem key_va=0x%x -> %r' % (addr, key_va, rdstr(key_va)))