#!/bin/bash
export TOOLCHAIN_DIR=/home/xialixin/ipc/toolchain/mips-ingenic-xburst2-toolchain
export PATH=${PATH}:${TOOLCHAIN_DIR}/bin
export COMPILER_CROSS=mips-linux-gnu-
export CROSS_COMPILE=mips-linux-gnu-

export CC=${COMPILER_CROSS}gcc
export LD=${COMPILER_CROSS}ld 
export STRIP=${COMPILER_CROSS}strip

