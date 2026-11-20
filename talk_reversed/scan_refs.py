import struct

d = open('/home/xialixin/ipc/image_raw/talk_reverse/bu_app.bin', 'rb').read()
text_off = 0x237c0
text_size = 0x1b62b0
base = 0x400000
GP = 0x66fae0

def sx16(v):
    return v - 0x10000 if v & 0x8000 else v

def decode(w):
    return w >> 26, (w >> 21) & 0x1f, (w >> 16) & 0x1f, w & 0xffff

# 目标 GOT 槽位 -> 说明
slots = {
    0x668850: 'audioRecv_tcp_recv',
    0x668868: 'bbm_audioRecvClientThread',
    0x668874: 'bbm_audioRecvThread',
}

words = [struct.unpack_from('<I', d, text_off + i)[0] for i in range(0, text_size, 4)]

results = []
for i, w in enumerate(words):
    op, rs, rt, imm = decode(w)
    va = text_off + i * 4 + base
    # lw $rt, imm($rs)  op=0x23,  rs 为基址寄存器
    if op == 0x23 and rs == 28:  # rs=28 = gp
        slot = GP + sx16(imm)
        if slot in slots:
            results.append((va, 'lw', rt, imm, slot, slots[slot]))
    # addiu $rt, $gp, imm  (先算地址再取值的另一种写法)
    elif op == 0x09 and rs == 28:
        slot = GP + sx16(imm)
        if slot in slots:
            results.append((va, 'addiu', rt, imm, slot, slots[slot]))

for r in sorted(results):
    print('VA 0x%08x: %-5s r%d imm=0x%04x -> GOT 0x%08x (%s)' % r)

print('total:', len(results))