## 一、硬件开发环境
- 君正T32 IPC摄像头
- SPI NAND 型号：F35SQA001G 
- SPI NAND ID : 0xcd71 

## 二、交叉编译工具链
- 交叉工具链路径： ./toolchain/r3.3.7-glibc-mxu2-cve2
- 交叉工具链前缀： mips-linux-uclibc-gnu-

## 三、现象
```
将打过补丁的rootfs (./images/rootfs/rootfs_patched.sqfs)刷入到 rootb 分区，然后让系统从B槽启动，
kernel不识别rootfs,并报错，错误日志的路径是：./images/notes/kernel.err。但是从A槽启动后，
手动挂载rootb[/dev/mtdblock4]分区能成功。
```
## 四、参考意见
- 我认为原来的kernel在执行加载rootfs的时候，有对rootfs做安全校验

## 五、任务
- 1.请根据我提供的日志（./images/notes/kernel.err）逆向分析vmlinx(./images/kernel/vmlinx)是否存加载rootfs的时候做安全校验
- 2.如果有安全校验，请帮我打个补丁，跳过安全校验

