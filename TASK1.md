## 一、硬件开发环境
- 君正T32 IPC摄像头
- SPI NAND 型号：F35SQA001G 
- SPI NAND ID : 0xcd71 

## 二、交叉编译工具链
- 交叉工具链路径： ./toolchain/r3.3.7-glibc-mxu2-cve2
- 交叉工具链前缀： mips-linux-uclibc-gnu-

## 三、刷机环境
### 3.1 cloner 刷机环境
- 刷机工具路径：./images/burning/cloner
- 刷机所使用到的固件路径：./images/burning/cloner/.tmp/firmwares/T32
- 刷机所使用到的配置文件：./images/burning/cloner/.tmp/configs/T32/t32_all_sfc_nand_linux.cfg 

### 3.2 fastboot 刷机环境
- fastboot 刷机脚本路径：./images/burning/fastboot

### 3.3 刷机方法
- 1.先把从u-boot编译出来的产物u-boot.bin拷贝到./images/burning/cloner/.tmp/firmwares/T32/uboot.bin
- 2.使用cloner 刷机，让T32能够将uboot.bin 运行起来，然后进入fastboot模式
- 3.使用fastboot.flash.all.sh 将固件全部刷入系统

## 四、当前遇到的问题
- 把从u-boot编译生成的产物 u-boot-with-spl.bin 通过fastboot模式刷入uboot分区，重新上电u-boot-with-spl.bin 没有运行起来

## 五、需要解决的问题（任务）
- 处理为什么把u-boot-with-spl.bin 刷入到uboot分区后，系统无法进入到uboot阶段，甚至spl阶段都没有进入


## 六、参考信息
- cloner 刷机工具中的固件 ./images/burning/cloner/.tmp/firmwares/T32/spl.bin 是可以执行的

