#!/usr/bin/env bash
set -euo pipefail

feed="https://nikkinikki.pages.dev/openwrt-$RELEASE_SERIES/x86_64/nikki/packages.adb"
mkdir -p "$BUILDER_DIR/keys" "$FILES/etc/apk/keys" "$FILES/etc/apk/repositories.d"
curl -fsSL --retry 3 -o "$FILES/etc/apk/keys/nikki.pem" 'https://nikkinikki.pages.dev/public-key.pem'
cp "$FILES/etc/apk/keys/nikki.pem" "$BUILDER_DIR/keys/nikki.pem"
grep -Fxq "$feed" "$BUILDER_DIR/repositories" || printf '\n%s\n' "$feed" >> "$BUILDER_DIR/repositories"
printf '%s\n' "$feed" > "$FILES/etc/apk/repositories.d/nikki.list"
