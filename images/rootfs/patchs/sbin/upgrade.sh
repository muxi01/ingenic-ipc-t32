#!/bin/sh

if [ "$1" = "" ] ; then 
    echo "$0 <image>"
    exit 1
fi

if [ -f $1 ] ; then 
    if cat $1 |grep -q rootfs ; then 
        flash_eraseall /dev/mtd3
        nandwrite /dev/mtd3 $1
    else
        echo "$1 is not a rootfs image"
        exit 1 
    fi 
fi
