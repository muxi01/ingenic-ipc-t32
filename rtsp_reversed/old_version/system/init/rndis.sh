#!/bin/sh

#RNDIS 网卡

echo "Initialize RNDIS network"

mount -t configfs none /sys/kernel/config
cd /sys/kernel/config/usb_gadget
mkdir gl
cd gl
echo 0x0502 > idVendor
echo 0x3235 > idProduct
mkdir strings/0x409
echo "123456" > strings/0x409/serialnumber
echo "Ingenic" > strings/0x409/manufacturer
echo "RNDIS" > strings/0x409/product
mkdir configs/c.1
mkdir configs/c.1/strings/0x409
echo "rndis" > configs/c.1/strings/0x409/configuration
mkdir functions/rndis.usb0
ln -s functions/rndis.usb0 configs/c.1
ls /sys/class/udc > UDC

wlan0=`ifconfig -a | grep usb0`
trial=0
maxtrycnt=50
while [ -z "$wlan0" ] && [ $trial -le $maxtrycnt ]
do 
    sleep 0.2
    #echo currect try $trial...
    trial=$(($trial + 1 ))
    wlan0=`ifconfig -a | grep usb0`
done
if [ $trial -le $maxtrycnt ]; then
    echo try usb0 $trial times
fi
if [ $trial -gt $maxtrycnt ];then
    echo usb0 not found
    exit -1
fi

echo "Set RNDIS network IP 192.168.172.1"
ifconfig usb0 192.168.172.1 netmask 255.255.255.0 up

