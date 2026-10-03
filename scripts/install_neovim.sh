#!/usr/bin/env bash
# Install Neovim via apt if missing. Idempotent.
set -euo pipefail

if command -v nvim &>/dev/null; then
    echo "==> Neovim already installed: $(nvim --version | head -1)"
    exit 0
fi

echo "==> Installing neovim"
sudo apt-get update -qq
sudo apt-get install -y neovim
