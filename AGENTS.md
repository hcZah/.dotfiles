# AGENTS.md — guidance for coding agents working on this dotfiles repo

Repo: `github.com/hcZah/.dotfiles`, default branch `main`. Real files live here; most are symlinked into `$HOME`/`~/.config` by `relink.sh`.

## Repository layout

```
.dotfiles/
├─ AGENTS.md          # this file (real file, NOT symlinked)
├─ README.md          # user-facing setup/install docs
├─ setup.sh           # main bootstrap: installs components, relinks, sets zsh default shell
├─ relink.sh          # recreates symlinks (backups real files to *.bak.<ts>)
├─ scripts/           # standalone idempotent component installers
├─ zsh/               # .zshrc, .zshenv         -> $HOME/
├─ tmux/              # tmux.conf              -> ~/.config/tmux
├─ nvim/              # init.lua + lua/        -> ~/.config/nvim
├─ ghostty/           # config + themes        -> ~/.config/ghostty
└─ environment.d/     # im.conf                -> ~/.config/environment.d
```

`setup.sh` runs component installers from `scripts/` (`tools`, `neovim`, `ghostty`, `nvm`, `font`), then `relink.sh`, then sets zsh as default shell. `relink.sh` links:
- `zsh/.zshrc` → `$HOME/.zshrc`
- `zsh/.zshenv` → `$HOME/.zshenv`
- `tmux` → `~/.config/tmux`
- `nvim` → `~/.config/nvim`
- `ghostty` → `~/.config/ghostty`
- `environment.d` → `~/.config/environment.d`

## Neovim plugin conventions (the most commonly edited part)

Entry: `nvim/init.lua` → `config.options`, `config.keymaps`, `config.lazy`.
`nvim/lua/config/lazy.lua` runs `require("lazy").setup("plugins")`, so **every file in `nvim/lua/plugins/*.lua` is auto-discovered** — no registration needed.

Each plugin file returns a table of lazy.nvim specs. Example (`nvim/lua/plugins/oil.lua`):

```lua
return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({ ... })
      vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "..." })
    end,
  },
}
```

Conventions to follow when adding a plugin:
- One file per plugin (or per concern) under `nvim/lua/plugins/`.
- Use the `config = function() ... end` pattern; call `require("<plugin>").setup({ ... })`.
- Put keymaps inside `config` with `{ desc = "..." }`.
- Prefer `ft = "<filetype>"` for lazy-loading filetype plugins.
- Pin `version = "*"` for plugins that release tags (e.g. render-markdown.nvim).
- Dependencies already present: `nvim-treesitter/nvim-treesitter` (in `navigation.lua`, parsers `markdown` + `markdown_inline` already ensured), `nvim-tree/nvim-web-devicons`.

## Treesitter

Configured in `nvim/lua/plugins/navigation.lua` via `nvim-treesitter.configs`. `ensure_installed` includes `lua, vim, vimdoc, bash, markdown, markdown_inline`. If a new parser is needed, add it to that list — no separate plugin file required.

## Testing changes

- Neovim: start `nvim`, run `:Lazy install` to fetch new plugins, open a target filetype to verify, then `:Lazy sync` to update `lazy-lock.json` (commit both the plugin file and lockfile).
- Shell/tmux/ghostty: changes take effect via `relink.sh` or restarting the program.

## Git

- Branch: `main`, remote: `origin` (github.com/hcZah/.dotfiles.git).
- Commit style: short, component-prefixed summary, e.g. `Neovim: add render-markdown.nvim ...`.
