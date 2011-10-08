#!/bin/bash

# The initramfs folder.
FOLDER=stock

# The initramfs source path.
INITRAMFSDIR=/home/$LOGNAME/samsung-kernel-c1spr/initramfs/$FOLDER/

# Change directories to the initramfs directory.
cd /home/$LOGNAME/samsung-kernel-c1spr/initramfs/$FOLDER/

# Remove the hidden git files if they are in the directory.
rm -rf .git/

# Change directory to the kernel source.
cd /home/$LOGNAME/samsung-kernel-c1spr/source/SPH-D710/

# Tell the compiler we are building for arm.
export ARCH=arm

# Export to where the cross compiler is.
export CROSS_COMPILE=/home/$LOGNAME/samsung-kernel-c1spr/toolchain/arm-eabi-4.4.0/bin/arm-eabi-

# Triple make sure the build directory is clean.
make distclean
make clean

# Configure the correct defconfig.
make c1_rev05_na_spr_defconfig

# Set the initramfs directory and build the zImage.
make -j8 CONFIG_INITRAMFS_SOURCE="$INITRAMFSDIR"

# Copy the freshly compiled modules to the initramfs.
cp drivers/samsung/j4fs/j4fs.ko $INITRAMFSDIR/lib/modules/
cp drivers/scsi/scsi_wait_scan.ko $INITRAMFSDIR/lib/modules/
cp drivers/bluetooth/bthid/bthid.ko $INITRAMFSDIR/lib/modules/
cp drivers/net/wireless/bcm4330/dhd.ko $INITRAMFSDIR/lib/modules/
cp drivers/samsung/vibetonz/vibrator.ko $INITRAMFSDIR/lib/modules/
cp drivers/staging/westbridge/astoria/switch/cyasswitch.ko $INITRAMFSDIR/lib/modules/

# Build the kernel again with the same initramfs, but with newly compiled modules.
make -j8 CONFIG_INITRAMFS_SOURCE="$INITRAMFSDIR"

# Copy the zImage to the Desktop.
cd arch/arm/boot/
cp zImage /home/$LOGNAME/Desktop/zImage
cd /home/$LOGNAME/Desktop/
rm SPH-D710_Kernel_Gingerbread.tar 
tar cvf SPH-D710_Kernel_Gingerbread.tar zImage
rm zImage

