#!/usr/bin/env bash
# Install NVM if missing. Idempotent.
set -euo pipefail

if [[ -d "$HOME/.nvm" ]]; then
    echo "==> NVM already installed"
    exit 0
fi

echo "==> Installing NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
echo "==> NVM installed. Restart your shell or source ~/.zshrc / ~/.bashrc"
