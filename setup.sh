#!/usr/bin/env bash
#
# setup.sh - Bootstrap dotfiles environment.
#
# Ensures the repo lives at ~/.dotfiles, lets you opt in/out of each
# component installer, and (re)creates all symlinks via relink.sh.
#
# Usage:
#   ./setup.sh              # interactive, per-component prompts
#   ./setup.sh --yes        # install everything without asking
#   ./setup.sh --only tools,nvm   # only run the listed components
#   ./setup.sh --skip nvm   # run everything except the listed components
#
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ASSUME_YES=0
ONLY=""
SKIP=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -y|--yes) ASSUME_YES=1; shift ;;
        --only) ONLY="$2"; shift 2 ;;
        --skip) SKIP="$2"; shift 2 ;;
        -h|--help)
            grep '^#' "$0" | sed 's/^# \{0,1\}//'
            exit 0 ;;
        *) echo "Unknown option: $1" >&2; exit 1 ;;
    esac
done

# ------------------------------------------------------------------
# 1. Make sure the dotfiles live in ~/.dotfiles
# ------------------------------------------------------------------
if [[ "$SCRIPT_DIR" != "$DOTFILES_DIR" ]]; then
    echo "==> Copying dotfiles from $SCRIPT_DIR to $DOTFILES_DIR"
    if [[ -d "$DOTFILES_DIR" ]]; then
        cp -r "$SCRIPT_DIR"/. "$DOTFILES_DIR"/
    else
        cp -r "$SCRIPT_DIR" "$DOTFILES_DIR"
    fi
    echo "==> Re-running setup from $DOTFILES_DIR"
    exec "$DOTFILES_DIR/setup.sh" "$@"
fi

cd "$DOTFILES_DIR"

# ------------------------------------------------------------------
# 2. Component installers (each one is standalone and idempotent)
# ------------------------------------------------------------------
COMPONENTS=(
    "tools:scripts/install_tools.sh:zsh, tmux, fzf, ripgrep, fd, bat, eza, zoxide"
    "neovim:scripts/install_neovim.sh:Neovim (skipped if already installed)"
    "ghostty:scripts/install_ghostty.sh:Ghostty terminal (skipped if already installed)"
    "nvm:scripts/install_nvm.sh:Node Version Manager"
    "font:scripts/install_jetbrains_nerd_font.sh:JetBrainsMono Nerd Font"
)

want() {
    local name="$1"
    if [[ -n "$ONLY" && ",$ONLY," != *",$name,"* ]]; then return 1; fi
    if [[ -n "$SKIP" && ",$SKIP," == *",$name,"* ]]; then return 1; fi
    return 0
}

for entry in "${COMPONENTS[@]}"; do
    name="${entry%%:*}"
    rest="${entry#*:}"
    script="${rest%%:*}"
    desc="${rest#*:}"

    want "$name" || { echo "==> Skipping $name"; continue; }

    if [[ $ASSUME_YES -eq 0 ]]; then
        read -r -p "Install $name ($desc)? [y/N] " answer
        [[ "$answer" =~ ^[Yy]$ ]] || { echo "==> Skipping $name"; continue; }
    fi

    echo "==> Running $script"
    bash "$script"
done

# ------------------------------------------------------------------
# 3. Symlinks
# ------------------------------------------------------------------
echo "==> Creating symlinks"
bash "$DOTFILES_DIR/relink.sh"

# ------------------------------------------------------------------
# 4. Set zsh as the default shell
# ------------------------------------------------------------------
if command -v zsh &>/dev/null; then
    ZSH_PATH="$(command -v zsh)"
    if [[ "${SHELL:-}" != "$ZSH_PATH" ]]; then
        if ! grep -qx "$ZSH_PATH" /etc/shells; then
            echo "==> Adding $ZSH_PATH to /etc/shells"
            echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
        fi
        echo "==> Setting zsh as default shell"
        chsh -s "$ZSH_PATH" || echo "!! Could not change shell; run: chsh -s $ZSH_PATH"
    else
        echo "==> zsh is already the default shell"
    fi
else
    echo "!! zsh not found; skipping default-shell change"
fi

echo "==> Done. Start a new shell or run: exec zsh"
