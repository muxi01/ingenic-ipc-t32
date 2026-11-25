#!/bin/bash


[ -e squashfs-root ] && rm -rf squashfs-root

unsquashfs ../mtds/mtds_nanddump/mtd3_rootfs.dump

if [ $? == 0 ] ; then 
	cp -rf ./patchs/* ./squashfs-root/
	mksquashfs ./squashfs-root rootfs.patched -comp lzo -b 131072 -noappend -processors 4
	
	file ../mtds/mtds_nanddump/mtd3_rootfs.dump
	file ./rootfs.patched
fi


