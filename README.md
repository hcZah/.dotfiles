# .dotfiles

Minimal, opinionated dev environment for Kubuntu: **Zsh** + **Tmux** + **Neovim** + **Ghostty**, all themed with [Moonfly](https://github.com/bluz71/vim-moonfly-colors).

## Quick setup

```bash
git clone https://github.com/hcZah/.dotfiles.git ~/.dotfiles && bash ~/.dotfiles/setup.sh
```

`setup.sh` installs components (with per-component prompts), creates all symlinks, and sets zsh as the default shell.

## What's included

| Component | Purpose | Highlights |
|-----------|---------|------------|
| **Zsh** | Interactive shell | Transient prompt (`user in <dir> git:(branch)` → `❯`), preserves `$PATH`/NVM/aliases |
| **Tmux** | Multiplexer | Prefix `Ctrl-a`, status bar on top, Moonfly palette, vim-tmux-navigator (`Ctrl-h/j/k/l`) |
| **Neovim** | Editor | lazy.nvim, Telescope, Treesitter, Mason + LSP, nvim-cmp, Moonfly theme |
| **Ghostty** | Terminal | JetBrainsMono Nerd Font, Moonfly palette |
| **Scripts** | Installers | Standalone, idempotent component installers |

## Repository layout

```
~/.dotfiles/
├─ zsh/               # .zshrc, .zshenv        → $HOME/
├─ tmux/              # tmux.conf              → ~/.config/tmux
├─ nvim/              # init.lua + lua/        → ~/.config/nvim
├─ ghostty/           # config + themes        → ~/.config/ghostty
├─ environment.d/     # im.conf               → ~/.config/environment.d
├─ scripts/           # Component installers
├─ setup.sh           # Main bootstrap
└─ relink.sh          # Symlink manager
```

## Using the scripts

### `setup.sh` — full bootstrap

```bash
~/.dotfiles/setup.sh                    # interactive prompts per component
~/.dotfiles/setup.sh --yes              # install everything, no prompts
~/.dotfiles/setup.sh --only tools,font  # only listed components
~/.dotfiles/setup.sh --skip nvm         # everything except listed components
```

Components: `tools`, `neovim`, `ghostty`, `nvm`, `font`.

### `relink.sh` — recreate symlinks

Run it after changing the dotfiles layout or when a symlink breaks:

```bash
~/.dotfiles/relink.sh
```

It backs up real files to `*.bak.<timestamp>` and relinks `~/.zshrc`, `~/.zshenv`, `~/.config/tmux`, `~/.config/nvim`, `~/.config/ghostty`, and `~/.config/environment.d`.

### `scripts/` — individual installers

Each is standalone and idempotent, safe to run anytime:

```bash
bash ~/.dotfiles/scripts/install_tools.sh                      # zsh, tmux, fzf, ripgrep, fd, bat, eza, zoxide
bash ~/.dotfiles/scripts/install_neovim.sh                     # Neovim
bash ~/.dotfiles/scripts/install_ghostty.sh                    # Ghostty terminal
bash ~/.dotfiles/scripts/install_nvm.sh                        # Node Version Manager
bash ~/.dotfiles/scripts/install_jetbrains_nerd_font.sh        # JetBrainsMono Nerd Font
```

## After setup

```bash
exec zsh     # reload shell
ghostty      # launch terminal
tmux         # start multiplexer
nvim         # start editor
```

## Customisation

- **Font size** — `font-size` in `~/.config/ghostty/config`
- **Tmux prefix** — `set -g prefix C-a` in `tmux/tmux.conf`
- **Colorscheme** — swap `bluz71/vim-moonfly-colors` in `nvim/lua/plugins/colorscheme.lua`
- **Plugins** — add a module under `nvim/lua/plugins/`

## License

Personal dotfiles — fork and adapt freely. No warranty provided.
