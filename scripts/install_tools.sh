#!/usr/bin/env bash
# Install core CLI tools via apt (Ubuntu/Debian). Idempotent.
set -euo pipefail

PKGS=(zsh tmux fzf ripgrep fd-find bat eza zoxide)

echo "==> Updating apt cache"
sudo apt-get update -qq

for pkg in "${PKGS[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
        echo "==> $pkg already installed"
    else
        echo "==> Installing $pkg"
        sudo apt-get install -y "$pkg" || echo "!! Failed to install $pkg (may not exist in your repos)"
    fi
done

# Ubuntu names the binaries fdfind/batcat; provide familiar aliases if missing
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    echo "==> Tip: fd-find installs 'fdfind'; add: alias fd=fdfind"
fi
if ! command -v bat &>/dev/null && command -v batcat &>/dev/null; then
    echo "==> Tip: bat installs 'batcat'; add: alias bat=batcat"
fi
