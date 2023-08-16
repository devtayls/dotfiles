-- TODO: Describe Packer
return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set Header
			dashboard.section.header.val = {
				"██████╗  █████╗ ███████╗███████╗██╗     ██╗███╗   ██╗███████╗",
				"██╔══██╗██╔══██╗██╔════╝██╔════╝██║     ██║████╗  ██║██╔════╝",
				"██████╔╝███████║███████╗█████╗  ██║     ██║██╔██╗ ██║█████╗  ",
				"██╔══██╗██╔══██║╚════██║██╔══╝  ██║     ██║██║╚██╗██║██╔══╝  ",
				"██████╔╝██║  ██║███████║███████╗███████╗██║██║ ╚████║███████╗",
				"╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝",
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("<space><space>", "find files", ":Telescope find_files<CR>"),
				dashboard.button("?", "Learn Base", ":e init.lua<CR>"),
			}

			alpha.setup(dashboard.opts)
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", 'nvim-telescope/telescope-symbols.nvim' },
		config = function()
			require("fuzzy")
		end,
	})

	use({
		"neanias/everforest-nvim",
		config = function()
			-- require("everforest").setup()
			require("everforest").setup({
				---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
				---Default is "medium".
				background = "soft",
				---How much of the background should be transparent. 2 will have more UI
				---components be transparent (e.g. status line background)
				transparent_background_level = 2,
				---@param highlight_groups Highlights
				---@param palette Palette
				on_highlights = function(highlight_groups, palette) end,
			})
			vim.cmd([[colorscheme everforest]])
		end,
	})

	use({
		"tpope/vim-fugitive",
		requires = {
			"tpope/vim-rhubarb",
		},
		config = function()
			-- Open pane displaying changed files
			vim.keymap.set("n", "<leader>gg", "<CMD>G<CR>")
			vim.keymap.set("n", "<leader>gl", "<CMD>Gclog<CR>")
			vim.keymap.set("n", "<leader>gh", "<CMD>0Gclog<CR>")
			vim.keymap.set("n", "<leader>gb", "<CMD>Git blame<CR>")
			vim.keymap.set("n", "<leader>gd", "<CMD>Gdiff<CR>")
			vim.keymap.set("n", "<leader>gw", "<CMD>Gwrite<CR>")
			vim.keymap.set("n", "<leader>gr", "<CMD>Gread<CR>")
			-- Put things in quick list
			vim.keymap.set("n", "<leader>gw", "<CMD>Git difftool --name-only<CR>")
			vim.keymap.set("n", "<leader>gW", "<CMD>Git difftool<CR>")

			-- use arrows to put / get hunks in diff views
			vim.keymap.set("n", "<leader>g<left>", "<CMD>diffget<CR>")
			vim.keymap.set("n", "<leader>g<right>", "<CMD>diffget<CR>")
			vim.keymap.set("n", "<leader>g<down>", "<CMD>diffput<CR>")
			vim.keymap.set("v", "<leader>g<down>", "<CMD>diffput<CR><ESC>")
		end,
	})

	use({
		"rhysd/git-messenger.vim",
		config = function()
			vim.keymap.set("n", "<leader>gm", "<CMD>GitMessenger<CR>")
		end,
	})

	use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("elixir-editors/vim-elixir")
	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("language_servers")
		end,
		after = {
			"nvim-cmp",
		},
	})

	use({
		"christoomey/vim-tmux-navigator",
		config = function()
			vim.g.tmux_navigator_disable_when_zoomed = true
		end,
	})
	use({
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
			vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")
			vim.keymap.set("n", "<leader>E", ":NvimTreeToggle<cr>")
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")

			function next_hunk()
				-- Move to next hunk
				gitsigns.next_hunk()
				-- center cursor
				vim.cmd("normal zz")
			end

			function prev_hunk()
				-- Move to prev hunk
				gitsigns.prev_hunk()
				-- center cursor
				vim.cmd("normal zz")
			end

			gitsigns.setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "│" },
					topdelete = { text = "│" },
					changedelete = { text = "│" },
				},
				on_attach = function(bufnr)
					local map = vim.keymap.set
					local opts = { silent = true }

					-- map('n', ']g', next_hunk, opts)
					-- map('n', '[g', prev_hunk, opts)
					-- map('n', '<leader>g+', gitsigns.stage_hunk, opts)
					-- map('n', '<leader>g-', gitsigns.undo_stage_hunk, opts)
					-- map('n', '<leader>g=', gitsigns.reset_hunk, opts)
					-- map('n', '<leader>gp', gitsigns.preview_hunk, opts)
				end,
			})

			local wk = require("which-key")

			wk.register({
				["<leader>g"] = { name = "+git" },
				["<leader>g+"] = { gitsigns.stage_hunk, "Stage Hunk" },
				["<leader>g-"] = { gitsigns.undo_stage_hunk, "Unstage Hunk" },
				["<leader>g="] = { gitsigns.reset_hunk, "Reset Hunk" },
				["<leader>gp"] = { gitsigns.preview_hunk, "Show Changes" },
			})
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter")
		end,
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
		},
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("autocompletion")
		end,
	})

	use({
		"janko/vim-test",
		requires = {
			"tpope/vim-dispatch",
			"neomake/neomake",
			"preservim/vimux",
		},

		config = function()
			local g = vim.g
			local v = vim.v

			-- set orientation to show test runner on right side of screen
			g.VimuxOrientation = "h"

			-- set width of test panel
			g.VimuxHeight = "30"

			local map = vim.keymap.set
			map("n", "<leader>tt", "<CMD>TestFile<CR>")
			map("n", "<leader>tn", "<CMD>TestNearest<CR>")
			map("n", "<leader>t.", "<CMD>TestLast<CR>")
			map("n", "<leader>tv", "<CMD>TestVisit<CR>zz")
			map("n", "<leader>ts", "<CMD>TestSuite<CR>")
			map("n", "<leader>tc", "<CMD>VimuxClearTerminalScreen<CR>")
			map("n", "<leader>tq", "<CMD>VimuxCloseRunner<CR>")
			-- Use Projectionist to jump to related test<>code file
			map("n", "<leader>t<backspace>", "<CMD>:A<CR>")

			g["test#strategy"] = {
				nearest = "vimux",
				file = "vimux",
				suite = "vimux",
			}
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup()
		end,
	})

	use({
		"mfussenegger/nvim-lint",
		config = function()
			require("linting")
		end,
	})

	-- SQL viewer
	use({
		"tpope/vim-dadbod",
		requires = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			vim.g.db_ui_use_nerd_fonts = true
			vim.g.db_ui_execute_on_save = false
			vim.g.db_ui_disable_mappings = true
		end,
	})

	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})

	use({
		"tpope/vim-projectionist",
		setup = function()
			vim.g.projectionist_heuristics = {
				["*"] = {
					["*.ex"] = {
						alternate = {
							"{}_test.exs",
						},
						type = "source",
					},
					["*_test.exs"] = {
						alternate = {
							"{}.ex",
						},
					},
				},
			}
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"jpalardy/vim-slime",
		setup = function()
			vim.g.slime_target = "tmux"
			vim.g.slime_default_config = { socket_name = "default", target_pane = "{right}" }
			vim.g.slime_dont_ask_default = 1
		end,
		config = function()
			vim.keymap.set("n", "<leader>w", "<Plug>SlimeParagraphSend")
		end,
	})
end)
