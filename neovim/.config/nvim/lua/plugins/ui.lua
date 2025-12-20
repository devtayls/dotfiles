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
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function()
			local leap = require("leap")
			leap.opts.safe_labels = {}

			-- Modern leap mappings (replaces deprecated add_default_mappings)
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
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
	-- Colorscheme plugins (terminal sync is handled by lua/themes/init.lua)
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "soft",
				transparent_background_level = 2,
				on_highlights = function(hl, palette)
					-- Clear backgrounds to let Kitty transparency show through
					hl.Normal = { fg = palette.fg, bg = "NONE" }
					hl.NormalFloat = { fg = palette.fg, bg = "NONE" }
					hl.SignColumn = { fg = palette.fg, bg = "NONE" }
				end,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
		end,
	},
	{
		"everviolet/nvim",
		name = "evergarden",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.evergarden_transparent_background = true
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
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
		lazy = false,
		config = function()
			local wk = require("which-key")
			wk.setup({
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
	},
}
