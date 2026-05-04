return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			enabled = true, -- Enable the plugin
			scope = {
				enabled = true, -- Enable scope highlighting
				show_start = true, -- Show line at start of scope
				show_end = true, -- Show line at end of scope
				injected_languages = false, -- Don't show scope in injected languages
				highlight = { "Function", "Label" }, -- Highlight groups for scope lines (matches everforest)
				priority = 500, -- Priority for scope highlighting
			},
			indent = {
				char = "│", -- Show indent lines with vertical bar
				tab_char = "│", -- Show tab indent lines with vertical bar
			},
			whitespace = {
				remove_blankline_trail = false, -- Keep trailing whitespace on blank lines
			},
			exclude = {
				filetypes = { -- Don't show indent lines in these file types
					"help",
					"snacks_dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "yaml", "terraform", "tf" },
				callback = function(args)
					require("ibl").setup_buffer(args.buf, {
						indent = { char = "▏" },
					})
				end,
			})
		end,
	},
}
