#!/bin/bash
set -euo pipefail

SPL="./spl/spl.base.image"
UBOOT="./u-boot.bin"
OUT="./u-boot-with-spl-new.bin"
SPL_PAD_TO=$((0x6800))

for f in "$SPL" "$UBOOT"; do
	if [ ! -f "$f" ]; then
		echo "ERROR: not found: $f"
		exit 1
	fi
done

spl_size=$(stat -c%s "$SPL")
uboot_size=$(stat -c%s "$UBOOT")

if [ "$spl_size" -gt "$SPL_PAD_TO" ]; then
	echo "ERROR: spl ($spl_size bytes) exceeds uboot offset 0x$(printf '%x' "$SPL_PAD_TO")"
	exit 1
fi

tmp_spl=$(mktemp)
dd if="$SPL" of="$tmp_spl" bs=1 count="$spl_size" status=none
if [ "$spl_size" -lt "$SPL_PAD_TO" ]; then
	dd if=/dev/zero of="$tmp_spl" bs=1 count=$((SPL_PAD_TO - spl_size)) seek="$spl_size" conv=notrunc status=none
fi

cat "$tmp_spl" "$UBOOT" > "$OUT"
rm -f "$tmp_spl"

echo "merged -> $OUT"
echo "size: $(stat -c%s "$OUT") bytes = spl 0x$(printf '%x' "$spl_size") + pad + uboot $uboot_size"
echo "--- offset 0x0000 (spl header) ---"
xxd -l 16 "$OUT"
echo "--- offset 0x6800 (uboot start) ---"
xxd -s 0x6800 -l 16 "$OUT"

