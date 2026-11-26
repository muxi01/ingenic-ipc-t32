#!/bin/bash

fastboot devices

fastboot flash uboot     ./temp/mtd0.uboot
[ $? == 0] || echo "failed to flash uboot"
sleep 0.5

fastboot flash kernel_a  ./temp/mtd1.kernel
[ $? == 0] || echo "failed to flash kernel_a"
sleep 0.5

fastboot flash kernel_b  ./temp/mtd1.kernel
[ $? == 0] || echo "failed to flash kernel_b"
sleep 0.5

fastboot flash root_a    ./temp/mtd3.rootfs
[ $? == 0] || echo "failed to flash root_a"
sleep 0.5

fastboot flash root_b    ./temp/mtd3.rootfs
[ $? == 0] || echo "failed to flash root_b"
sleep 0.5

fastboot flash lullaby   ./temp/mtd5
[ $? == 0] || echo "failed to flash lullaby"
sleep 0.5

fastboot flash info      ./temp/mtd6
[ $? == 0] || echo "failed to flash info"
sleep 0.5

fastboot flash flag      ./temp/mtd7
[ $? == 0] || echo "failed to flash flag"
sleep 0.5

fastboot flash flag1     ./temp/mtd8
[ $? == 0] || echo "failed to flash flag1"
sleep 0.5

