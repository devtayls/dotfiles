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
	["<leader><leader>"] = { builtins.find_files, "Files" },
	["<leader>/"] = { builtins.live_grep, "GREP" },
	["<leader>gs"] = { builtins.git_status, "git status" },
	["<leader><Backspace>"] = { builtins.buffers, "Buffers" },
})
