return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<leader>fm", "<cmd>Noice telescope<cr>", desc = "Search message history" },
	},
	opts = {
		lsp = {
			-- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				enabled = true,
				silent = false, -- show message when hover is not available
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true, -- auto-show signature help when typing trigger character
					luasnip = true,
					throttle = 50,
				},
			},
			-- Show progress messages for LSP operations
			progress = {
				enabled = true,
				format = "lsp_progress",
				format_done = "lsp_progress_done",
				throttle = 1000 / 30,
				view = "mini",
			},
		},
		views = {
			hover = {
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				position = { row = 2, col = 2 },
				size = {
					max_width = 80,
					max_height = 20,
				},
				win_options = {
					wrap = true,
					linebreak = true,
				},
			},
		},
		routes = {
			{
				view = "hover",
				filter = { event = "lsp", kind = "hover" },
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- disable to use custom noice styling
		},
	},
}
