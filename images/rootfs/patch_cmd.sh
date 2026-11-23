#!/bin/bash


[ -e squashfs-root ] && rm -rf squashfs-root

unsquashfs ../mtds/mtds_nanddump/mtd3_rootfs.bin

if [ $? == 0 ] ; then 
	cp -rf ./patchs/* ./squashfs-root/
	mksquashfs ./squashfs-root rootfs_patched.sqfs -comp lzo -b 131072 -noappend -processors 4
	
	file ../mtds/mtds_nanddump/mtd3_rootfs.bin
	file ./rootfs_patched.sqfs
fi


