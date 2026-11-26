## 一、硬件开发环境
- 君正T32 IPC摄像头
- SPI NAND 型号：F35SQA001G 
- SPI NAND ID : 0xcd71 

## 二、交叉编译工具链
- 交叉工具链路径： ./toolchain/r3.3.7-glibc-mxu2-cve2
- 交叉工具链前缀： mips-linux-uclibc-gnu-

## 三、任务
- 请把./images/notes/env.info 中的环境变量信息配置到u-boot工程中，并让系统能默认运行bootcmd
