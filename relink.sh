#!/usr/bin/env bash
#
# relink.sh - Remove and recreate all dotfiles symlinks.
# Safe to run repeatedly; backs up real files it would replace.
#
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
TS="$(date +%Y%m%d%H%M%S)"

link() {
    local src="$1" dst="$2"
    if [[ -L "$dst" ]]; then
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        echo "==> Backing up $dst -> ${dst}.bak.${TS}"
        mv "$dst" "${dst}.bak.${TS}"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "==> $dst -> $src"
}

link "$DOTFILES_DIR/zsh/.zshrc"  "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/tmux"        "$HOME/.config/tmux"
link "$DOTFILES_DIR/nvim"        "$HOME/.config/nvim"
link "$DOTFILES_DIR/ghostty"     "$HOME/.config/ghostty"
link "$DOTFILES_DIR/environment.d" "$HOME/.config/environment.d"

echo "==> All symlinks recreated."
