#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ] ; then
    echo "Usage: $0 gpio value"
	echo "speaker -> 40"
    exit 1
else
    gpioX="gpio$1"
    if [ -e /sys/class/gpio/$gpioX ] ; then 
        echo out > /sys/class/gpio/$gpioX/direction
        echo $2 > /sys/class/gpio/$gpioX/value
    else
        echo $1 > /sys/class/gpio/export
        echo out > /sys/class/gpio/$gpioX/direction
        echo $2 > /sys/class/gpio/$gpioX/value
    fi
fi


