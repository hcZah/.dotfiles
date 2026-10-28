return {
  -- Pretty markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = "markdown",
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown" },
      })

      vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown render" })
    end,
  },
}
