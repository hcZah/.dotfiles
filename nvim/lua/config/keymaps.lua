local map = vim.keymap.set

-- Open a 15-line terminal pane at the bottom (Super+t)
map("n", "<leader>t", "<cmd>botright 15split | terminal<CR>", { desc = "Terminal pane at bottom" })

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Remap number increment to Ctrl-b (since Ctrl-a is the Tmux prefix)
map("n", "<C-b>", "<C-a>", { desc = "Increment number" })
map("v", "<C-b>", "<C-a>", { desc = "Increment number" })

-- Better visual indenting (keeps selection active)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered during scrolling / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
