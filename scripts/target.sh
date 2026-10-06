#!/usr/bin/env bash
set -euo pipefail

config="$BUILDER_DIR/.config"
formats='CONFIG_(ISO_IMAGES|QCOW2_IMAGES|VDI_IMAGES|VHDX_IMAGES|VMDK_IMAGES|TARGET_ROOTFS_TARGZ|TARGET_ROOTFS_SQUASHFS|GRUB_IMAGES)'

case "$IMAGE_MODE" in
    all)
        sed -i -E "s/^# ($formats) is not set$/\1=y/" "$config"
        ;;
    ext4-efi)
        sed -i -E "s/^($formats)=y/# \1 is not set/" "$config"
        ;;
    *)
        exit 1
        ;;
esac

sed -i -E 's/^# (CONFIG_TARGET_ROOTFS_EXT4FS|CONFIG_GRUB_EFI_IMAGES) is not set$/\1=y/' "$config"
