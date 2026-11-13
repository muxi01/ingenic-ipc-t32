#!/bin/bash
export TOOLCHAIN_DIR=$(pwd)/toolchain/r5.1.12-uclibc
export PATH=${PATH}:${TOOLCHAIN_DIR}/bin
export CROSS_COMPILE=mips-linux-uclibc-

export CC=${COMPILER_CROSS}gcc
export LD=${COMPILER_CROSS}ld 
export STRIP=${COMPILER_CROSS}strip

