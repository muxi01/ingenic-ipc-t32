# 核心任务
- 交叉编译ffmpeg-8.0.1

# 交叉编译环境
- 交叉编译工具链路径：/home/.../ipq5000-router/arm-linux-musleabi-cross
- 交叉编译工具链前缀: rm-linux-musleabi-
- 拉起环境变量的方法： source enviroment.sh 

# 运行环境
- ipq5000 的 路由器设备

# 编译要求
- 不需要对ffmpeg打补丁，补丁文件0001-mips-msa-gcc15-fixes.patch 直接无视
- 必须使用静态链接的方式来编译
- 编译配置由 ffmpeg.mk 提供，配置条件是BR2_PACKAGE_THINGINO_FFMPEG_IPC=y 

