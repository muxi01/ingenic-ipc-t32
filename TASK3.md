## 一、硬件开发环境
- 君正T32 IPC摄像头
- SPI NAND 型号：F35SQA001G 
- SPI NAND ID : 0xcd71 

## 二、交叉编译工具链
- 交叉工具链路径： ./toolchain/r3.3.7-glibc-mxu2-cve2
- 交叉工具链前缀： mips-linux-uclibc-gnu-

## 三、任务
- 1.写一个python脚本用于拆解 ./images/kernel/kernel.img 并拿到vmlinux的可执行程序vmlinux.bin
- 2.写一个封包的脚本，用于将vmlinux.bin 封包成 kernel.img (u-boot legacy uImage)
