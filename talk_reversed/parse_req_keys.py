import re

data = open('bu_app.bin', 'rb').read()
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

addr2idx = {a: i for i, (a, _) in enumerate(ins)}

def reg_init(reg, idx, window=40):
    base = None
    for j in range(max(0, idx - window), idx):
        _, pt = ins[j]
        mm = re.fullmatch(r'lui\s+' + reg + r',\s*0x([0-9a-f]+)', pt)
        if mm:
            base = int(mm.group(1), 16) << 16
            # 回溯中途可能被覆盖，直接返回最后一次匹配到的最快(即最靠近的)
    return base

def resolve_addiu(reg, off, idx):
    b = reg_init(reg, idx)
    if b is not None:
        return b + off
    return None

# 收集所有 GetObjectItem(4402ac) 调用
calls = []
for i, (a, t) in enumerate(ins):
    if 0x444438 <= a <= 0x446000 and 'jal\t4402ac' in t:
        key = None
        # a1 由前一指令 (delay slot in branch) 或前一条 addiu/lui 设置
        # 模式1: delay slot: move a0,s3; 上一条 addiu a1,reg,off
        prev_txt = ins[i - 1][1] if i >= 1 else ''
        prev2_txt = ins[i - 2][1] if i >= 2 else ''
        m1 = re.fullmatch(r'addiu\s+a1,\s*(\w+),\s*((?:0x[0-9a-f]+)|-?[0-9]+)', ins[i - 1][1] if i >= 1 else '')
        m2 = re.fullmatch(r'addiu\s+a1,\s*(\w+),\s*((?:0x[0-9a-f]+)|-?[0-9]+)', ins[i - 2][1] if i >= 2 else '')
        m = m1 or m2
        if m:
            va = resolve_addiu(m.group(1), int(m.group(2), 0), i)
            if va is not None:
                key = rdstr(va) or hex(va)
        # 缺失/类型错后报错出口（往前找 addiu a0,sp,180; b 443c44; addiu a3,.. 模式）
        req = False
        # 找 beqz v0 目标
        j = i
        while j < min(i + 8, len(ins)):
            _, pt = ins[j]
            mb = re.fullmatch(r'beqz\s+v0,\s*([0-9a-f]+)', pt)
            if mb and j > i:
                dst = int(mb.group(1), 16)
                break
            j += 1
        else:
            dst = None
        if dst is not None:
            di = addr2idx.get(dst)
            if di is not None:
                # 目标处若很快出现 b 443c44 → 缺失报错
                for k in range(di, min(di + 3, len(ins))):
                    if 'b\t443c44' in ins[k][1]:
                        req = True
        calls.append((a, key, req))

for a, key, req in calls:
    print('0x%x GetObjectItem(%s) %s' % (a, key, 'REQUIRED' if req else 'optional'))