# 核心任务
- 交叉编译ffmpeg-8.0.1

# 交叉编译环境
- 交叉编译工具链路径： ../toolchain/r3.3.7-glibc-mxu2-cve2
- 交叉编译工具链前缀:  mips-linux-uclibc-gnu-
- 拉起环境变量的方法： source enviroment.sh 

# 运行环境
- 君正T32 IPC 监控设备

# 编译要求
- 1.先解压缩ffmpeg-8.0.1.tar.gz文件到当前目录
- 2.使用补丁文件0001-mips-msa-gcc15-fixes.patch 打补丁
- 3.编译ffmpeg-8.0.1，使用ffmpeg.mk配置文件，配置条件是BR2_PACKAGE_THINGINO_FFMPEG_IPC=y 
- 4.编译完成后，使用shell脚本固化这个操作方法

