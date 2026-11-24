#!/bin/bash

fastboot devices

fastboot flash uboot     ./temp/mtd0
fastboot flash kernel_a  ./temp/mtd1
fastboot flash kernel_b  ./temp/mtd2
fastboot flash root_a    ./temp/mtd3.rootfs
fastboot flash root_b    ./temp/mtd3.rootfs
fastboot flash lullaby   ./temp/mtd5
fastboot flash info      ./temp/mtd6
fastboot flash flag      ./temp/mtd7
fastboot flash flag1     ./temp/mtd8
fastboot flash config    ./temp/mtd9

