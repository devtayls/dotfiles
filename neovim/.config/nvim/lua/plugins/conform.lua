return {
	{
		"stevearc/conform.nvim",
		dependencies = {
			"which-key.nvim",
		},
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome", "prettier" },
				javascriptreact = { "biome", "prettier" },
				typescript = { "biome", "prettier" },
				typescriptreact = { "biome", "prettier" },
				json = { "biome" },
				jsonc = { "biome" },
				elixir = { "mix" },
				terraform = { "terraform_fmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
				timeout_ms = 1000,
			},
			-- Set up format-on-save
			format_on_save = {
        timeout_ms = 2500,
        lsp_format = "fallback"
      },
		},
	},
}
