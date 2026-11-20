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

def fmt_target(addr):
    return '_ftext::0x%x' % addr

for i, (addr, txt) in enumerate(ins):
    m = re.search(r'jal\s+([0-9a-f]+)', txt)
    if not (m and int(m.group(1), 16) == 0x4402ac):
        continue
    # only within type=1 handler region
    if not (0x444438 < addr < 0x445a00):
        continue
    key_va = walk_a1(i)
    key = rdstr(key_va) if key_va else None
    # collect next ~8 instructions: beqz and type-check
    ctx = []
    for j in range(i + 1, min(i + 9, len(ins))):
        a, t = ins[j]
        ctx.append('%08x: %s' % (a, t))
        if re.search(r'(beqz|beq|bnez|bne)\s', t):
            ctx.append('  <-- branch')
            break
    print('### 0x%08x GetObjectItem("%s") va=0x%x' % (addr, key, key_va or 0))
    for c in ctx[:6]:
        print('    ' + c)
    print()