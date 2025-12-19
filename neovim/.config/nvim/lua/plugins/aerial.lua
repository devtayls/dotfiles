return {
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false, -- Load on startup
		keys = {
			{ "<leader>lS", "<cmd>AerialToggle<cr>", desc = "Toggle aerial sidebar" },
		},
		opts = {
			layout = {
				default_direction = "left",
				min_width = 25,
			},
			attach_mode = "global",
			backends = { "treesitter", "lsp", "markdown", "man" },
			show_guides = true,
			filter_kind = {
				"Class",
				"Function",
				"Method",
				"Module",
				"Interface",
				"Constructor",
				"Struct",
			},
			treesitter = {
				update_delay = 300,
			},
		},
	},
}
