return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			-- Diagnostics
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			
			-- LSP
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / References (Trouble)" },
			
			-- Location/Quickfix
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			
			-- Navigation
			{ "]t", function() require("trouble").next({skip_groups = true, jump = true}) end, desc = "Next trouble item" },
			{ "[t", function() require("trouble").prev({skip_groups = true, jump = true}) end, desc = "Previous trouble item" },
		},
		opts = {
			modes = {
				-- Enhanced preview mode
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
				-- Buffer diagnostics mode
				buffer_diagnostics = {
					mode = "diagnostics",
					filter = { buf = 0 },
				},
			},
			-- Auto-behavior
			auto_close = true,
			auto_preview = true,
			auto_fold = false,
			-- Position and size
			position = "bottom",
			height = 10,
			-- Icons and styling
			icons = true,
			fold_open = "",
			fold_closed = "",
			indent_lines = true,
			-- Action keys for better navigation
			action_keys = {
				close = "q",
				cancel = "<esc>",
				refresh = "r",
				jump = { "<cr>", "<tab>" },
				open_split = { "<c-x>" },
				open_vsplit = { "<c-v>" },
				open_tab = { "<c-t>" },
				jump_close = { "o" },
				toggle_mode = "m",
				toggle_preview = "P",
				hover = "K",
				preview = "p",
				close_folds = { "zM", "zm" },
				open_folds = { "zR", "zr" },
				toggle_fold = { "zA", "za" },
				previous = "k",
				next = "j",
			},
		},
	},
}
