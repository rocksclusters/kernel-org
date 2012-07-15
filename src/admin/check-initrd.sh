#!/bin/sh
# The creates an initrd file if none exists and adds it to the
# default kernel entry
GRUBBY=/sbin/grubby
MKINITRD=/sbin/mkinitrd
kernelversion=@KERNEL-VERSION@
kerneldefault=`$GRUBBY --default-kernel`
initrddefault=/boot/initramfs-${kernelversion}.img
$GRUBBY --info="$kerneldefault" | grep '^initrd' 2>&1 > /dev/null
if [ $? -ne 0 ]; then
	echo "initrd line not found! Making initial ramdisk" |  tee /tmp/kernel-org/fix-initrd.log
	$MKINITRD "$initrddefault" "$kernelversion" 
 	$GRUBBY --initrd="$initrddefault" --update-kernel="$kerneldefault"
fi
