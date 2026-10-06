#!/usr/bin/env bash
set -euo pipefail

ROOT="$FILES/root"
ZSH="$ROOT/.oh-my-zsh"

mkdir -p "$ROOT"
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH/custom/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH/custom/plugins/zsh-syntax-highlighting"
cp "$ZSH/templates/zshrc.zsh-template" "$ROOT/.zshrc"
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="ys"/; s/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ROOT/.zshrc"
