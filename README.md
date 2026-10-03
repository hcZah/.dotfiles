# Development Environment – Dotfiles Overview

This repository contains a **minimal, opinionated configuration** for a development workflow on Kubuntu.  It is structured to keep the heavy‑lifting in **Tmux** and **Neovim**, while the terminal emulator **Ghostty** provides quick, seemless input.

---

## Directory Layout

```
~/.dotfiles/
├─ zsh/               # ~/.zshrc → $HOME/.zshrc
│   └─ .zshrc
├─ tmux/              # ~/.config/tmux/tmux.conf
│   └─ tmux.conf
├─ nvim/              # ~/.config/nvim (full Neovim config)
│   ├─ init.lua
│   └─ lua/
│       ├─ config/
│       │   ├─ options.lua      # core options
│       │   ├─ keymaps.lua
│       │   └─ lazy.lua        # lazy.nvim bootstrap
│       └─ plugins/
│           ├─ colorscheme.lua # Moonfly colorscheme
│           ├─ navigation.lua  # telescope, tmux‑navigator, treesitter
│           └─ lsp.lua         # mason, lspconfig, nvim‑cmp
├─ ghostty/           # ~/.config/ghostty
│   ├─ config         # main Ghostty config (solid Moonfly backdrop)
│   └─ themes/
│       └─ moonfly    # official palette from bluz71/vim-moonfly-colors
├─ scripts/           # Standalone, idempotent component installers
│   ├─ install_tools.sh              # zsh, tmux, fzf, rg, fd, bat, eza, zoxide
│   ├─ install_neovim.sh
│   ├─ install_ghostty.sh
│   ├─ install_nvm.sh
│   └─ install_jetbrains_nerd_font.sh
├─ setup.sh          # Main bootstrap: runs component installers + symlinks
├─ relink.sh         # Destroys and recreates all symlinks
└─ README.md         # You are reading it!
```

---

## Key Features

| Component | Purpose | Highlights |
|-----------|---------|------------|
| **Zsh** | Primary interactive shell | Preserves existing `$PATH`, NVM, and aliases from Bash.  Uses a **transient prompt** that shows `user in <dir> git:(branch)` and collapses to `❯` after each command. |
| **Tmux** | Terminal multiplexer | Prefix is `Ctrl‑a`.  Status bar on **top** uses the **Moonfly** colour palette.  Splits inherit the current directory.  Integrated `vim‑tmux‑navigator` for seamless pane navigation via `Ctrl‑h/j/k/l`. |
| **Neovim** | Core editor | Managed with **lazy.nvim**.  Plugins for Moonfly theme, Telescope, Treesitter, Mason + LSP, and nvim‑cmp.  Number increment remapped to `Ctrl‑b` (so it does not clash with the Tmux prefix). |
| **Ghostty** | Minimal terminal emulator | Ghostty provides quick, seamless input with a solid background.  Config located at `~/.config/ghostty/config` uses **JetBrainsMono Nerd Font** and the Moonfly palette (from `ghostty/themes/moonfly`).  Does not interfere with Tmux or Neovim – it simply provides the backdrop. |
| **Setup** (`setup.sh`) | Bootstrapper | Ensures the repo lives at `~/.dotfiles`, interactively runs each component installer (with opt-out), recreates all symlinks, and sets zsh as the default shell. |
| **Relink** (`relink.sh`) | Symlink manager | Removes and recreates every symlink; backs up real files it replaces. Run it after modifying the dotfiles layout. |

---

## Installing / Bootstrapping

Run the main setup script — it installs the software (you can opt out of each
component) and creates all symlinks:

```bash
chmod +x ~/.dotfiles/setup.sh ~/.dotfiles/relink.sh ~/.dotfiles/scripts/*.sh
~/.dotfiles/setup.sh            # interactive prompts per component
~/.dotfiles/setup.sh --yes      # install everything, no prompts
~/.dotfiles/setup.sh --only tools,font   # only selected components
~/.dotfiles/setup.sh --skip nvm          # everything except NVM
```

Each installer in `scripts/` is standalone and idempotent, so you can also run
them individually, e.g. `bash ~/.dotfiles/scripts/install_tools.sh`.

### Recreating the symlinks

Anytime you change the dotfiles layout or a symlink breaks, rebuild them all:

```bash
~/.dotfiles/relink.sh
```

It removes existing symlinks/files (backing up real files to `*.bak.<timestamp>`)
and recreates: `~/.zshrc`, `~/.config/tmux`, `~/.config/nvim`, `~/.config/ghostty`.

After that, start a new terminal (or run `exec zsh`) and launch Ghostty:

```bash
ghostty   # opens a new Ghostty window
```

Inside Ghostty you can start Tmux:
```bash
tmux
```
and then open Neovim:
```bash
nvim
```
Neovim will display the Moonfly colours provided by Ghostty.

---

## Customisation Tips

- **Font size** – edit `font-size = 11` in `~/.config/ghostty/config`.
- **Background opacity** – `background-opacity` in `~/.config/ghostty/config` is `1.0` (solid); lower it only if you want translucency.
- **Tmux prefix** – change `set -g prefix C-a` to another key if you prefer.
- **Neovim colour scheme** – replace `bluz71/vim-moonfly-colors` with any other theme in `plugins/colorscheme.lua`.
- **Additional plugins** – add a new module under `nvim/lua/plugins/` and reference it in `lazy.lua`.

---

## License & Contributions

This set of dotfiles is **personal** but feel free to fork, modify, and adapt it for your own workflow.  No warranty is provided.

---
