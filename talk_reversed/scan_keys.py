import re

data = open('bu_app.bin', 'rb').read()

def rdstr(va):
    off = va - 0x400000
    if off < 0 or off >= len(data):
        return None
    e = data.index(0, off) if 0 in data[off:off + 64] else off + 1
    b = data[off:e]
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
byaddr = {a: (t, i) for i, (a, t) in enumerate(ins)}

calls = []
for i, (a, t) in enumerate(ins):
    m = re.search(r'jal\s+([0-9a-f]+)', t)
    if m and int(m.group(1), 16) == 0x4402ac:
        if 0x444400 <= a <= 0x447000:
            calls.append(i)
print('total calls in range: %d' % len(calls))


def regval(i, reg):
    lo = max(0, i - 24)
    vals = {}
    for j in range(lo, i):
        _, t2 = ins[j]
        mm = re.fullmatch(r'lui\s+(\w+),0x([0-9a-f]+)', t2)
        if mm:
            vals[mm.group(1)] = int(mm.group(2), 16) << 16
            continue
        mm = re.fullmatch(r'li\s+(\w+),([-0-9]+)', t2)
        if mm:
            vals[mm.group(1)] = int(mm.group(2))
            continue
        mm = re.fullmatch(r'addiu\s+(\w+),(\w+),(-?0x[0-9a-f]+|-?[0-9]+)', t2)
        if mm:
            dst, src, off = mm.group(1), mm.group(2), mm.group(3)
            if src in vals:
                vals[dst] = vals[src] + int(off, 0)
            continue
        mm = re.fullmatch(r'move\s+(\w+),(\w+)', t2)
        if mm and mm.group(2) in vals:
            vals[mm.group(1)] = vals[mm.group(2)]
    return vals.get(reg)


for ci in calls:
    a, _ = ins[ci]
    # a1 key name: search backward for addiu a1,reg,off / move a1,reg / lui a1
    key = None
    a1_base = None
    a1_off = 0
    for j in range(ci, max(ci - 8, -1), -1):
        _, t2 = ins[j]
        mm = re.fullmatch(r'addiu\s+a1,(\w+),(-?0x[0-9a-f]+|-?[0-9]+)', t2)
        if mm:
            a1_base = regval(j, mm.group(1))
            a1_off = int(mm.group(2), 0)
            break
        mm = re.fullmatch(r'move\s+a1,(\w+)', t2)
        if mm:
            a1_base = regval(j, mm.group(1))
            a1_off = 0
            break
        mm = re.fullmatch(r'lui\s+a1,0x([0-9a-f]+)', t2)
        if mm:
            a1_base = int(mm.group(1), 16) << 16
            a1_off = 0
            break
    if a1_base is not None:
        key = rdstr(a1_base + a1_off)

    # beqz v0 err target
    err_tgt = None
    for j in range(ci + 1, ci + 6):
        _, t2 = ins[j]
        mm = re.search(r'beqz\s+v0,([0-9a-f]+)', t2)
        if mm:
            err_tgt = int(mm.group(1), 16)
            break
    err_first = None
    if err_tgt and err_tgt in byaddr:
        ei = byaddr[err_tgt][1]
        eseq = []
        for j in range(ei, min(ei + 4, len(ins))):
            ea, et = ins[j]
            eseq.append('%08x %s' % (ea, et))
        err_first = ' | '.join(eseq)
    # success path: next 12 instructions (type check + value handling)
    ok_seq = []
    for j in range(ci + 1, min(ci + 13, len(ins))):
        ea, et = ins[j]
        ok_seq.append('%08x %s' % (ea, et))
    ok_txt = ' ; '.join(ok_seq)
    print('0x%08x key=%s err->%s' % (
        a, key, ('0x%x' % err_tgt) if err_tgt else None))
    print('    OK: ' + ok_txt)