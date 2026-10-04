return {
  -- Oil: edit directories like buffers
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
      })

      vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory (oil)" })
    end,
  },
}
