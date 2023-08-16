local telescope = require("telescope")
local builtins = require("telescope.builtin")

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
	},
})

local wk = require("which-key")

wk.register({
	["<leader><leader>"] = { builtins.find_files, "files" },
	["<leader>/"] = { builtins.live_grep, "fzf" },
	["<leader>gs"] = { builtins.git_status, "changed files" },
	["<leader><Backspace>"] = { builtins.buffers, "buffers" },
	["<leader>f"] = { name = "+find" },
	["<leader>fi"] = { "<CMD>Telescope symbols<CR>", "🤓" },
})
