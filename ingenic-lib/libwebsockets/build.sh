
source enviroment.sh

mkdir build
cd build


cmake .. \
  -DCMAKE_SYSTEM_NAME=Linux \
  -DCMAKE_SYSTEM_PROCESSOR=mips \
  -DCMAKE_C_COMPILER=mips-linux-uclibc-gnu-gcc  \
  -DCMAKE_INSTALL_PREFIX=${ROOT_DIR}/install \
  -DLWS_WITH_SSL=OFF

