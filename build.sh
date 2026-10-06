#!/usr/bin/env bash
set -euo pipefail

# 软件包直接在此处维护；使用 -包名 移除官方默认包。
PACKAGES=""
PACKAGES+=" -luci-app-cpufreq"

PACKAGES+=" luci"
PACKAGES+=" luci-theme-argon luci-app-argon-config luci-i18n-argon-config-zh-cn"
PACKAGES+=" luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn"
PACKAGES+=" luci-i18n-package-manager-zh-cn"
PACKAGES+=" luci-i18n-diskman-zh-cn luci-i18n-statistics-zh-cn"

PACKAGES+=" firewall4 dnsmasq-full"
PACKAGES+=" nikki luci-app-nikki luci-i18n-nikki-zh-cn mihomo-meta"

PACKAGES+=" luci-i18n-frpc-zh-cn"
PACKAGES+=" luci-i18n-zerotier-zh-cn"
PACKAGES+=" luci-i18n-eqos-zh-cn"

PACKAGES+=" luci-i18n-openlist-zh-cn luci-i18n-filebrowser-go-zh-cn"
PACKAGES+=" luci-i18n-qbittorrent-zh-cn luci-i18n-aria2-zh-cn"
PACKAGES+=" curl ca-bundle unzip jsonfilter jshn"
PACKAGES+=" luci-i18n-p910nd-zh-cn"
PACKAGES+=" luci-i18n-samba4-zh-cn luci-i18n-vsftpd-zh-cn"
PACKAGES+=" kmod-usb-printer kmod-lp"

PACKAGES+=" git vim-fuller nano lrzsz htop"
PACKAGES+=" openssh-server openssh-client openssh-sftp-server"
PACKAGES+=" zsh"

# 只保留 Dockerman，旧 Docker 插件会绕过 dockerd 配置另起服务。
PACKAGES+=" luci-i18n-dockerman-zh-cn docker-compose"
PACKAGES+=" docker dockerd block-mount kmod-fs-ext4 e2fsprogs"

# 其他自定义软件包
# PACKAGES+=" "

# 生成固件
make image \
    PROFILE="$PROFILE" \
    PACKAGES="$PACKAGES" \
    FILES="$PWD/files" \
    DISABLED_SERVICES="sshd" \
    ROOTFS_PARTSIZE="$ROOTFS_SIZE"
