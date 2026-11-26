#!/bin/bash
#
# ffmpeg-8.0.1 交叉编译脚本 (TASK1)
#   目标:   君正 T32 IPC 监控设备 (MIPS32r2, 小端, hard-float, uClibc)
#   工具链:  r3.3.7-glibc-mxu2-cve2, 前缀 mips-linux-uclibc-gnu-
#   配置:    来源于 ffmpeg.mk, 条件 BR2_PACKAGE_THINGINO_FFMPEG_IPC=y
#   补丁:    0001-mips-msa-gcc15-fixes.patch (修复 MIPS MSA 内建类型不兼容)
#
# 使用方法:
#   cd /home/.../ipc/baby_monitor/ffmpeg
#   ./build1_ffmpeg.sh
#
set -e

# ---------------------------------------------------------------------------
# 工具链与路径配置 (按需修改)
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLCHAIN_DIR="$(cd "${SCRIPT_DIR}/../../toolchain/r3.3.7-glibc-mxu2-cve2" && pwd)"
CROSS_PREFIX="mips-linux-uclibc-gnu-"
# gcc wrapper(-muclibc) 的基准 sysroot; gcc 会自动追加 /uclibc 多库目录
SYSROOT="${TOOLCHAIN_DIR}/mips-linux-gnu/libc"

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
export PKG_CONFIG_LIBDIR="${SYSROOT}/uclibc/usr/lib/pkgconfig:${SYSROOT}/uclibc/lib/pkgconfig"

# 并行编译任务数 (可用环境变量覆盖, 默认取 CPU 核数)
MAKE_JOBS="${MAKE_JOBS:-$(nproc)}"

# ---------------------------------------------------------------------------
# 1. 解压缩源码到当前目录 (兼容 .tar.gz 与 .tar)
# ---------------------------------------------------------------------------
cd "${SCRIPT_DIR}"
SRC_DIR="${SCRIPT_DIR}/ffmpeg-8.0.1"
if [ ! -d "${SRC_DIR}" ]; then
    if [ -f "${SCRIPT_DIR}/ffmpeg-8.0.1.tar.gz" ]; then
        echo ">> 解压 ffmpeg-8.0.1.tar.gz ..."
        tar xzf "${SCRIPT_DIR}/ffmpeg-8.0.1.tar.gz"
    elif [ -f "${SCRIPT_DIR}/ffmpeg-8.0.1.tar" ]; then
        echo ">> 解压 ffmpeg-8.0.1.tar ..."
        tar xf "${SCRIPT_DIR}/ffmpeg-8.0.1.tar"
    else
        echo "!! 未找到 ffmpeg-8.0.1.tar.gz / ffmpeg-8.0.1.tar" >&2
        exit 1
    fi
fi

# ---------------------------------------------------------------------------
# 2. 打补丁 (幂等: 已打过则跳过)
# ---------------------------------------------------------------------------
PATCH_FILES=(
    "${SCRIPT_DIR}/0001-mips-msa-gcc15-fixes.patch"
    "${SCRIPT_DIR}/0002-mips-uclibc-auxv-fix.patch"
)
for PATCH_FILE in "${PATCH_FILES[@]}"; do
    [ -f "${PATCH_FILE}" ] || continue
    PATCH_NAME="$(basename "${PATCH_FILE}")"
    if patch -p1 --dry-run -d "${SRC_DIR}" < "${PATCH_FILE}" >/dev/null 2>&1; then
        echo ">> 应用补丁 ${PATCH_NAME} ..."
        patch -p1 -d "${SRC_DIR}" < "${PATCH_FILE}"
    else
        echo ">> 补丁 ${PATCH_NAME} 已应用或无法应用, 跳过"
    fi
done

# ---------------------------------------------------------------------------
# 进入源码目录并清理旧构建产物 (保证可复现)
# ---------------------------------------------------------------------------
cd "${SRC_DIR}"
rm -f config.cache config.mak config.h config_components.h config.log

# ---------------------------------------------------------------------------
# 3. 配置 (BR2_PACKAGE_THINGINO_FFMPEG_IPC=y 变体)
# ---------------------------------------------------------------------------
./configure \
  --enable-cross-compile \
  --cross-prefix="${CROSS_PREFIX}" \
  --sysroot="${SYSROOT}" \
  --host-cc=gcc \
  --arch=mipsel \
  --target-os=linux \
  --pkg-config=pkg-config \
  --prefix=/usr \
  --enable-mipsfpu \
  --enable-mipsdspr2 \
  --disable-msa \
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
  --disable-swresample \
  --enable-swresample \
  --enable-parser=h264,aac \
  --enable-parser=h264,opus \
  --enable-demuxer=rtsp \
  --enable-muxer=segment,mp4 \
  --enable-muxer=mp4,rtsp,avi,mpegts \
  --enable-bsf=h264_mp4toannexb,aac_adtastoasc \
  --enable-decoder=opus,h264,wrapped_avframe \
  --enable-encoder=aac,rawvideo \
  --enable-filter=color,testsrc,testsrc2,smptebars,rgbtestsrc \
  --enable-indev=lavfi \
  --cpu=mips32r2 \
  --extra-cflags="-Os -flto-partition=none -Dstatic_assert=_Static_assert" \
  --extra-ldflags="-z max-page-size=0x1000 -flto-partition=none -Wl,--gc-sections"

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
echo "动态依赖 (君正 T32 设备使用 uClibc, 预期动态依赖 ld-uClibc):"
"${CROSS_PREFIX}readelf" -d ffmpeg | grep -i 'NEEDED' || echo "(无 NEEDED 条目)"

echo ""
echo "体积: $(du -h ffmpeg | cut -f1)"
echo "输出路径: ${SRC_DIR}/ffmpeg"