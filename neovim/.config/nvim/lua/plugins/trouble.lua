return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			-- Diagnostics
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },

			-- LSP
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / References (Trouble)",
			},

			-- Location/Quickfix
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },

			-- Navigation
			{
				"]t",
				function()
					require("trouble").next({ skip_groups = true, jump = true })
				end,
				desc = "Next trouble item",
			},
			{
				"[t",
				function()
					require("trouble").prev({ skip_groups = true, jump = true })
				end,
				desc = "Previous trouble item",
			},
		},
		opts = {
			auto_close = true,
			win = {
				position = "bottom",
				size = { height = 10 },
			},
			keys = {
				j = "next",
				k = "prev",
				["<tab>"] = "jump",
			},
			modes = {
				-- Floating preview variant of diagnostics
				preview_float = {
					mode = "diagnostics",
					preview = {
						type = "float",
						relative = "editor",
						border = "rounded",
						title = "Preview",
						title_pos = "center",
						position = { 0, -2 },
						size = { width = 0.3, height = 0.3 },
						zindex = 200,
					},
				},
			},
		},
	},
}
