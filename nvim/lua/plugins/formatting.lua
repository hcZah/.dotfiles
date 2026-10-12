return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				cs = { "csharpier" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		})
	end,
}
