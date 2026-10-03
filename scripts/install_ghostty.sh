#!/usr/bin/env bash
# Install Ghostty via apt if missing. Idempotent.
set -euo pipefail

if command -v ghostty &>/dev/null; then
    echo "==> Ghostty already installed: $(ghostty --version | head -1)"
    exit 0
fi

echo "==> Installing ghostty"
sudo apt-get update -qq
sudo apt-get install -y ghostty || {
    echo "!! ghostty not available via apt on this system."
    echo "!! Install it manually: https://ghostty.org/docs/install"
    exit 1
}
