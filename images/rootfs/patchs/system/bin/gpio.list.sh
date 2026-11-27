#!/bin/sh
GPIO_BASE="/sys/class/gpio"

if [ ! -d "$GPIO_BASE" ]; then
    echo "错误: $GPIO_BASE 不存在（内核可能未启用 sysfs GPIO 或未挂载 sysfs）" >&2
    exit 1
fi

# ---------- 遍历并打印 ----------
found=0

printf "%-10s %-12s %-6s\n" "GPIO" "DIRECTION" "VALUE"
printf "%-10s %-12s %-6s\n" "----------" "------------" "------"

for d in "$GPIO_BASE"/gpio*; do
    [ -e "$d" ] || continue
    name=${d##*/}

    case "$name" in
        gpiochip*) continue ;;
        gpio[0-9]*) ;;
        *) continue ;;
    esac

    direction="-"
    value="-"

    [ -r "$d/direction" ] && direction=$(cat "$d/direction" 2>/dev/null)
    [ -r "$d/value" ]     && value=$(cat "$d/value" 2>/dev/null)

    printf "%-10s %-12s %-6s\n" "$name" "$direction" "$value"
    found=$((found + 1))
done

if [ "$found" -eq 0 ]; then
    echo "(未发现已导出的 GPIO)"
else
    echo "共 $found 个已导出 GPIO"
fi

exit 0


