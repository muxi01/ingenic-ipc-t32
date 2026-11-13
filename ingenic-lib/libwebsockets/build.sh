
source enviroment.sh

mkdir build
cd build


cmake .. \
  -DCMAKE_SYSTEM_NAME=Linux \
  -DCMAKE_SYSTEM_PROCESSOR=mips \
  -DCMAKE_C_COMPILER=mips-linux-gnu-gcc \
  -DCMAKE_INSTALL_PREFIX=../../../ingenic-lib/targetlib \
  -DLWS_WITH_SSL=OFF

