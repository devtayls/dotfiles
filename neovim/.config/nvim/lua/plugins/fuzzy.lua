return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"nvim-telescope/telescope-symbols.nvim",
			"which-key.nvim",
		},
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
			})

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
				{ "<leader>fi", "<CMD>Telescope symbols<CR>", desc = "🤓" },
				{ "<leader>fp", get_file_paths, desc = "telescope file paths" },
				{ "<leader>/", builtins.live_grep, desc = "telescope fzf" },
				{ "<leader>gs", builtins.git_status, desc = "telescope changed files" },
				{ "<leader><Backspace>", builtins.buffers, desc = "telescope buffers" },
			})
		end,
	},
}
