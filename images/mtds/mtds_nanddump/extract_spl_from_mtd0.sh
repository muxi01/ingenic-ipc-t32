#!/bin/bash
set -euo pipefail

SRC="./mtd0_uboot.dump"
OUT="./spl_from_mtd0.bin"

if [ ! -f "$SRC" ]; then
	echo "ERROR: source not found: $SRC"
	exit 1
fi

magic1=$(od -An -tx4 -j 0  -N 4 "$SRC" | tr -d ' \n')
magic2=$(od -An -tx4 -j 4  -N 4 "$SRC" | tr -d ' \n')
spl_len=$((0x$(od -An -tx4 -j 12 -N 4 "$SRC" | tr -d ' \n')))

echo "source          : $SRC"
echo "magic word1     : 0x$magic1 (expect 0x03040506)"
echo "magic word2     : 0x$magic2 (expect 0x55aa5502)"
echo "spl length field: $spl_len bytes (0x$(printf '%x' "$spl_len"))"

dd if="$SRC" of="$OUT" bs=1 count="$spl_len" status=none

echo "extracted -> $OUT"
echo "size: $(stat -c%s "$OUT") bytes"
echo "--- header ---"
xxd -l 16 "$OUT"
