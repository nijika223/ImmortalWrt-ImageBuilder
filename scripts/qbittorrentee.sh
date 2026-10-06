#!/usr/bin/env bash
set -euo pipefail

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

curl -fL --retry 3 --connect-timeout 15 --max-time 300 \
    -o "$work/release.zip" \
    'https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest/download/qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip'
unzip -p "$work/release.zip" qbittorrent-nox > "$work/qbittorrent-nox"
test -s "$work/qbittorrent-nox"
mkdir -p "$FILES/usr/bin"
install -m 0755 "$work/qbittorrent-nox" "$FILES/usr/bin/qbittorrent-nox"
chmod 0755 "$FILES/usr/libexec/qbittorrentee-update"
