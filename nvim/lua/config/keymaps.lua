local map = vim.keymap.set

-- Open a 15-line terminal pane at the bottom, in insert mode (Super+t)
map("n", "<leader>t", function()
	vim.cmd("botright 15split | terminal")
	vim.cmd("startinsert")
end, { desc = "Terminal pane at bottom" })

-- Exit terminal input mode with Esc Esc
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable mouse clicks (keep wheel scrolling)
map({ "n", "v", "i", "o" }, "<LeftMouse>", "<Nop>")
map({ "n", "v", "i", "o" }, "<LeftDrag>", "<Nop>")
map({ "n", "v", "i", "o" }, "<LeftRelease>", "<Nop>")
map({ "n", "v", "i", "o" }, "<RightMouse>", "<Nop>")
map({ "n", "v", "i", "o" }, "<RightDrag>", "<Nop>")
map({ "n", "v", "i", "o" }, "<RightRelease>", "<Nop>")
map({ "n", "v", "i", "o" }, "<MiddleMouse>", "<Nop>")

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

-- Format buffer with conform (falls back to LSP)
map({ "n", "v" }, "<leader>f", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
		timeout_ms = 3000,
	})
end, { desc = "Format file" })
