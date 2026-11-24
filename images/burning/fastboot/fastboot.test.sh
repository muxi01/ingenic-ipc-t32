#!/bin/bash

fastboot devices

fastboot flash uboot     ./temp/mtd0
fastboot flash kernel_a  ./temp/mtd1
fastboot flash kernel_b  ./temp/mtd2
fastboot flash root_a    ./temp/mtd3

