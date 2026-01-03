return {
	"folke/which-key.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"kyazdani42/nvim-web-devicons",
	},
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	lazy = false,
	config = function()
		local wk = require("which-key")
		wk.setup({
			preset = "helix", -- NEW: Right-side panel (LazyVim style)
			timeout = true,
			timeoutlen = 300,
		})

		-- Define key groups
		wk.add({
			{ "<leader>a", group = "+ai/claude" },
			{ "<leader>d", group = "+diagnostics" },
			{ "<leader>e", group = "+files" },
			{ "<leader>l", group = "+lsp" },
			{ "<leader>v", group = "+misc" },
			{ "<leader>x", group = "+trouble" },
		})
	end,
}
