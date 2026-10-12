return {
  -- Seamless navigation between Neovim splits and Tmux panes
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>sn", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find nvim config files" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "View keymaps" },
    },
    opts = {
      defaults = {
        path_display = { "truncate" },
      },
    },
  },

  -- Tree-sitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
