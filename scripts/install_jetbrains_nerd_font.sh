#!/usr/bin/env bash
set -euo pipefail

if fc-list : family | grep -iq "JetBrainsMono"; then
    echo "==> JetBrains Mono Nerd Font is already installed. Skipping."
    exit 0
fi

FONT_NAME="JetBrainsMono"
TARGET_DIR="/usr/local/share/fonts/${FONT_NAME}"
ARCHIVE_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
TMP_ARCHIVE="/tmp/JetBrainsMono.tar.xz"

echo "==> Downloading JetBrains Mono Nerd Font..."
curl -fLo "${TMP_ARCHIVE}" "${ARCHIVE_URL}"

echo "==> Creating system font directory at ${TARGET_DIR}..."
sudo mkdir -p "${TARGET_DIR}"

echo "==> Extracting fonts..."
sudo tar -xJf "${TMP_ARCHIVE}" -C "${TARGET_DIR}"
rm -f "${TMP_ARCHIVE}"

echo "==> Setting permissions..."
sudo chmod 755 "${TARGET_DIR}"
sudo chmod 644 "${TARGET_DIR}"/*

echo "==> Updating font cache..."
sudo fc-cache -fv

echo "==> Verifying installation..."
fc-list : family | grep -i "JetBrainsMono" || true

echo "==> Done!"
