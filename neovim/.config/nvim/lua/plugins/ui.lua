return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				disabled_filetypes = { "NvimTree" },
			},
		},
	},
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.opts.safe_labels = {}
			leap.add_default_mappings()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		keys = {
			{ "<leader>e", ":NvimTreeFindFileToggle<cr>", desc = "Open file tree at location" },
			{ "<leader>E", ":NvimTreeToggle<cr>", desc = "Open file tree at root" },
		},
		config = true,
	},
	{
		"neanias/everforest-nvim",
		config = function()
			require("everforest").setup({
				---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
				---Default is "medium".
				background = "soft",
				---How much of the background should be transparent. 2 will have more UI
				---components be transparent (e.g. status line background)
				transparent_background_level = 2,
				on_highlights = function(highlight_groups, palette) end,
			})
			vim.cmd([[colorscheme everforest]])
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.opts.hl = "Title"
			dashboard.section.header.val = {
				"                                        ████                                ",
				"                                    ████▒▒██                                ",
				"                                  ████  ▒▒██                                ",
				"                                ██▒▒  ▒▒▒▒▒▒██                              ",
				"                              ██▒▒██        ██                              ",
				"  ████                      ██▒▒██          ██                              ",
				"██▒▒▒▒██████                ██▒▒██      ▒▒  ████                            ",
				"██▒▒▒▒██    ████      ██████▒▒▒▒▒▒██    ▒▒▒▒██████████████                  ",
				"██▒▒    ████▒▒▒▒██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒▒████              ",
				"██▒▒▒▒      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██            ",
				"  ██▒▒      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████        ",
				"  ██        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██      ",
				"  ██▒▒    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
				"  ██▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
				"    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    ██▒▒▒▒▒▒▒▒▒▒████▒▒▒▒▒▒▒▒██  ",
				"    ████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██      ██▒▒▒▒▒▒████▒▒▒▒▒▒▒▒▒▒▒▒██  ",
				"    ██▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██        ██▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  ",
				"      ██▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██        ██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  ",
				"      ██▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██",
				"        ████  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██",
				"          ██    ▒▒██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒    ██▒▒  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██",
				"          ██            ████▒▒▒▒▒▒▒▒▒▒    ██  ▒▒  ▒▒        ▒▒▒▒▒▒▒▒▒▒▒▒██  ",
				"            ██                      ██  ████  ▒▒          ▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  ",
				"              ██                      ██▒▒██              ▒▒  ▒▒▒▒▒▒▒▒▒▒██  ",
				"                ██████████████████████▒▒▒▒██                    ▒▒▒▒▒▒██    ",
				"                      ██▒▒      ██▒▒▒▒▒▒▒▒██                    ▒▒▒▒██      ",
				"                      ██▒▒▒▒  ██▒▒▒▒▒▒▒▒████                  ▒▒▒▒██        ",
				"                      ██▒▒▒▒▒▒██▒▒▒▒▒▒██  ██                    ██          ",
				"                        ██████▒▒▒▒▒▒██    ██                ████            ",
				"                              ██████      ██          ██████                ",
				"                                            ██    ████                      ",
				"                                            ██████                          ",
			}
			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("<space><space>", "find files", ":Telescope find_files<CR>"),
				dashboard.button("?", "learn base", ":e init.lua<CR>"),
			}

			alpha.setup(dashboard.opts)
		end,
	},
	{
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
		opts = {
			timeout = true,
			timeoutlen = 300,
		},
		-- config = function()
		-- 	vim.o.timeout = true
		-- 	vim.o.timeoutlen = 300
		-- require("which-key").setup({
		-- 	-- your configuration comes here
		-- 	-- or leave it empty to use the default settings
		-- 	-- refer to the configuration section below
		-- })
		lazy = false,
		-- opts = {
		-- }
		-- config = function()
		-- 	vim.o.timeout = true
		-- 	vim.o.timeoutlen = 300
		-- 	require("which-key").setup({
		-- 		-- your configuration comes here
		-- 		-- or leave it empty to use the default settings
		-- 		-- refer to the configuration section below
		-- 	})
		-- end,
	},
}
