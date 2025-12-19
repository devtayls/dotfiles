return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"nvim-telescope/telescope-symbols.nvim",
			"folke/which-key.nvim",
			"mrloop/telescope-git-branch.nvim",
			{
				"nvim-telescope/telescope-frecency.nvim",
				version = "*",
			},
			"polirritmico/telescope-lazy-plugins.nvim",
		},
		lazy = false,
		config = function()
			local telescope = require("telescope")
			local builtins = require("telescope.builtin")
			local pickers = require("telescope.pickers")
			local sorters = require("telescope.sorters")
			local finders = require("telescope.finders")

			telescope.setup({
				defaults = {
					prompt_prefix = "󰭎 ",
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
					},
					initial_mode = "insert",
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"-g",
							"!.git",
							"--follow",
						},
					},
					buffers = {
						show_all_buffers = true,
					},
					live_grep = {
						vimgrep_arguments = {
							"rg",
							"--hidden",
							"-g",
							"!.git",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
						},
					},
				},
				extensions = {
					frecency = {
						show_unindexed = false, -- only show files you've opened
						ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
					},
					lazy_plugins = {
						lazy_config = vim.fn.stdpath("config") .. "/init.lua",
					},
				},
			})

			-- Load extensions
			telescope.load_extension("git_branch")
			telescope.load_extension("frecency")
			telescope.load_extension("lazy_plugins")

			-- tmux-file-paths helper
			local function get_file_paths()
				local picker = pickers.new({
					finder = finders.new_oneshot_job({ "tmux-file-paths" }, {
						entry_maker = function(entry)
							local _, _, filename, lnum = string.find(entry, "(.+):(%d+)")

							return {
								value = entry,
								ordinal = entry,
								display = entry,
								filename = filename,
								lnum = tonumber(lnum),
								col = 0,
							}
						end,
					}),
					sorter = sorters.get_generic_fuzzy_sorter(),
					previewer = require("telescope.previewers").vim_buffer_vimgrep.new({}),
				})

				picker:find()
			end

			local wk = require("which-key")
			wk.add({
				{ "<leader><leader>", builtins.find_files, desc = "telescope files" },
				{ "<leader>f", group = "+find" },
				{ "<leader>fc", builtins.commands, desc = "telescope commands" },
				{ "<leader>fi", "<CMD>Telescope symbols<CR>", desc = "🤓" },
				{ "<leader>fk", builtins.keymaps, desc = "telescope keymaps" },
				{ "<leader>fp", get_file_paths, desc = "telescope file paths" },
				{ "<leader>fP", "<CMD>Telescope lazy_plugins<CR>", desc = "telescope lazy plugins" },
				{ "<leader>fr", "<CMD>Telescope frecency workspace=CWD<CR>", desc = "telescope frecent files" },
				{ "<leader>fgb", "<CMD>Telescope git_branch<CR>", desc = "telescope git branch files" },
				{ "<leader>/", builtins.live_grep, desc = "telescope fzf" },
				{ "<leader>gs", builtins.git_status, desc = "telescope changed files" },
				{ "<leader>gc", builtins.git_commits, desc = "telescope git commits" },
				{ "<leader><Backspace>", builtins.buffers, desc = "telescope buffers" },
			})
		end,
	},
}
