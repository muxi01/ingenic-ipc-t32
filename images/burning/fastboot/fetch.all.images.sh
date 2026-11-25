#!/bin/bash

rm -rf ./temp
mkdir ./temp 

if [ "${ROOT_DIR}" = "" ] ; then 
	echo "please source enviroment.sh "
	exit 1
fi

./cut.tail.py -b 128k ${ROOT_DIR}/images/mtds/mtds_raw/mtdblock5 ./temp/mtd5 
./cut.tail.py -b 128k ${ROOT_DIR}/images/mtds/mtds_raw/mtdblock6 ./temp/mtd6 
./cut.tail.py -b 128k ${ROOT_DIR}/images/mtds/mtds_raw/mtdblock7 ./temp/mtd7 
./cut.tail.py -b 128k ${ROOT_DIR}/images/mtds/mtds_raw/mtdblock8 ./temp/mtd8 
./cut.tail.py -b 128k ${ROOT_DIR}/images/mtds/mtds_raw/mtdblock9 ./temp/mtd9 

./cut.tail.py -b 128k ${ROOT_DIR}/images/mtds/patched/u-boot-with-spl.patched 	./temp/mtd0.uboot 
./cut.tail.py -b 128k ${ROOT_DIR}/images/mtds/patched/kernel.patched 			./temp/mtd1.kernel
./cut.tail.py -b 128k ${ROOT_DIR}/images/rootfs/rootfs.patched 					./temp/mtd3.rootfs 

ls -al ./temp/


