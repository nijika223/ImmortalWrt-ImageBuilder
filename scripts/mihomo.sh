#!/usr/bin/env bash
set -euo pipefail

mihomo_version=$(curl -fsSL --retry 3 https://api.github.com/repos/MetaCubeX/mihomo/releases/latest |
    python3 -c 'import json, sys; print(json.load(sys.stdin)["tag_name"])')
echo "mihomo $mihomo_version"
mkdir -p "$FILES/usr/libexec"
curl -fL --retry 3 "https://github.com/MetaCubeX/mihomo/releases/download/$mihomo_version/mihomo-linux-amd64-v1-$mihomo_version.gz" |
    gzip -dc > "$FILES/usr/libexec/mihomo"
chmod 0755 "$FILES/usr/libexec/mihomo"
