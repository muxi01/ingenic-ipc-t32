#!/bin/bash
#
# ffmpeg-8.0.1 交叉编译脚本
#   目标:   arm-linux-musleabi (IPQ5000 路由器, ARM EABI5, musl libc)
#   链接:   完全静态 (static-pie)
#   配置:   来源于 ffmpeg.mk, 条件 BR2_PACKAGE_THINGINO_FFMPEG_IPC=y
#   补丁:   0001-mips-msa-gcc15-fixes.patch 按任务要求忽略 (MIPS 专用)
#
# 说明:
#   - ffmpeg.mk 中的 --enable-mipsfpu / --enable-mipsdspr2 / --disable-msa
#     以及 --cpu=mips32r2 均为 MIPS 专用选项, ARM 目标不适用, 已移除。
#   - --enable-static --disable-shared 只保证 ffmpeg 自带库静态编译;
#     为使 ffmpeg 可执行文件本身不再动态依赖 musl libc / libatomic,
#     --extra-ldflags 中额外加入了 -static。
#
set -e

# ---------------------------------------------------------------------------
# 工具链与路径配置 (按需修改)
# ---------------------------------------------------------------------------
TOOLCHAIN_DIR="$(pwd)/../../router/ipq5000-router/arm-linux-musleabi-cross"
CROSS_PREFIX="arm-linux-musleabi-"
SYSROOT="${TOOLCHAIN_DIR}/arm-linux-musleabi"

# ---------------------------------------------------------------------------
# 环境变量
# ---------------------------------------------------------------------------
export PATH="${TOOLCHAIN_DIR}/bin:${PATH}"
export CROSS_COMPILE="${CROSS_PREFIX}"
export CC="${CROSS_PREFIX}gcc"
export CXX="${CROSS_PREFIX}g++"
export AR="${CROSS_PREFIX}ar"
export LD="${CROSS_PREFIX}ld"
export STRIP="${CROSS_PREFIX}strip"
export RANLIB="${CROSS_PREFIX}ranlib"

# 隔离 pkg-config 查找路径, 防止误链宿主机上的第三方库
export PKG_CONFIG_LIBDIR="${SYSROOT}/lib/pkgconfig"

# 并行编译任务数 (可用环境变量覆盖, 默认取 CPU 核数)
MAKE_JOBS="${MAKE_JOBS:-$(nproc)}"

# ---------------------------------------------------------------------------
# 进入源码目录
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FFMPEG_DIR="${SCRIPT_DIR}/ffmpeg-8.0.1"
cd "${FFMPEG_DIR}"

# ---------------------------------------------------------------------------
# 清理旧构建产物, 保证可复现
# ---------------------------------------------------------------------------
make distclean >/dev/null 2>&1 || true
rm -f config.cache

# ---------------------------------------------------------------------------
# 配置 (BR2_PACKAGE_THINGINO_FFMPEG_IPC=y 变体)
# ---------------------------------------------------------------------------
./configure \
  --enable-cross-compile \
  --cross-prefix="${CROSS_PREFIX}" \
  --sysroot="${SYSROOT}" \
  --host-cc=gcc \
  --arch=arm \
  --target-os=linux \
  --pkg-config=pkg-config \
  --prefix=/usr \
  --enable-gpl \
  --enable-version3 \
  --enable-avformat \
  --enable-avcodec \
  --enable-network \
  --enable-ffmpeg \
  --enable-avdevice \
  --enable-protocol=file \
  --enable-protocol=tcp \
  --enable-protocol=udp \
  --disable-encoders \
  --disable-decoders \
  --disable-hwaccels \
  --disable-parsers \
  --disable-indevs \
  --disable-outdevs \
  --disable-filters \
  --disable-bsfs \
  --disable-demuxers \
  --disable-muxers \
  --disable-protocols \
  --disable-debug \
  --disable-doc \
  --disable-htmlpages \
  --disable-manpages \
  --disable-podpages \
  --disable-txtpages \
  --disable-ffplay \
  --disable-ffprobe \
  --disable-iconv \
  --disable-zlib \
  --disable-swscale \
  --disable-cuda \
  --disable-cuda-llvm \
  --disable-shared \
  --enable-static \
  --disable-libx264 \
  --disable-libx265 \
  --disable-libdav1d \
  --disable-libvpx \
  --disable-libopus \
  --enable-swresample \
  --enable-parser=h264,aac,opus \
  --enable-demuxer=rtsp \
  --enable-muxer=segment,mp4,rtsp,avi,mpegts \
  --enable-bsf=h264_mp4toannexb,aac_adtastoasc \
  --enable-decoder=opus,h264,wrapped_avframe \
  --enable-encoder=aac,rawvideo \
  --enable-filter=color,testsrc,testsrc2,smptebars,rgbtestsrc \
  --enable-indev=lavfi \
  --extra-cflags="-Os -flto-partition=none" \
  --extra-ldflags="-static -z max-page-size=0x1000 -flto-partition=none -Wl,--gc-sections"

# ---------------------------------------------------------------------------
# 编译
# ---------------------------------------------------------------------------
make -j"${MAKE_JOBS}"

# ---------------------------------------------------------------------------
# 验证产物
# ---------------------------------------------------------------------------
echo ""
echo "===================================================================="
echo "构建完成, 产物信息:"
echo "===================================================================="
file ffmpeg

echo ""
echo "动态依赖检查 (应为空, 表示完全静态):"
if "${CROSS_PREFIX}readelf" -d ffmpeg | grep -qi 'NEEDED'; then
  echo "!!! 存在动态依赖, 未达成完全静态链接 !!!"
  "${CROSS_PREFIX}readelf" -d ffmpeg | grep -i 'NEEDED'
  exit 1
else
  echo "OK: 无任何动态依赖 (fully static)"
fi

echo ""
echo "体积: $(du -h ffmpeg | cut -f1)"
echo "输出路径: ${FFMPEG_DIR}/ffmpeg"