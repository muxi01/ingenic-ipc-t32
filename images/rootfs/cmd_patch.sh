#!/bin/bash


[ -e squashfs-root ] && rm -rf squashfs-root
[ -e rootfs.patched ] && rm -rf rootfs.patched 

unsquashfs ../mtds/mtds_nanddump/mtd3_rootfs.dump

if [ $? == 0 ] ; then 
	rm -f squashfs-root/usr/sbin/udhcpd 
	cp -rfp ./patchs/* ./squashfs-root/
	mksquashfs ./squashfs-root rootfs.patched -comp lzo -b 131072 -noappend -processors 4
	
	file ../mtds/mtds_nanddump/mtd3_rootfs.dump
	file ./rootfs.patched
fi


