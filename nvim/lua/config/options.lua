local opt = vim.opt

-- Appearance & Theme
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.colorcolumn = "80"

-- Tabs & Indents
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Window splits
opt.splitright = true
opt.splitbelow = true

-- Persistent undo & performance
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.mouse = "nvi"
vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[hi NormalFloat guibg=NONE ctermbg=NONE]])
