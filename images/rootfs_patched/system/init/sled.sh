#!/bin/sh

GPIO_NUM=45

echo $GPIO_NUM > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$GPIO_NUM/direction

while true; do
    echo 1 > /sys/class/gpio/gpio$GPIO_NUM/value
    sleep 0.5
    echo 0 > /sys/class/gpio/gpio$GPIO_NUM/value
    sleep 0.5
done