#!/bin/bash
export TOOLCHAIN_DIR=$(pwd)/../toolchain/r3.3.7-glibc-mxu2-cve2
export PATH=${PATH}:${TOOLCHAIN_DIR}/bin
export CROSS_COMPILE=mips-linux-uclibc-gnu-

export CC=${CROSS_COMPILE}gcc
export LD=${CROSS_COMPILE}ld 
export AR=${CROSS_COMPILE}ar
export STRIP=${CROSS_COMPILE}strip

