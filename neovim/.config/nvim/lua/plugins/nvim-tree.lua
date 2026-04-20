return {
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	keys = {
		{ "<leader>e", ":NvimTreeFindFileToggle<cr>", desc = "Open file tree at location" },
		{ "<leader>E", ":NvimTreeToggle<cr>", desc = "Open file tree at root" },
	},
	opts = {
		filters = {
			dotfiles = false,
			git_ignored = true,
		},
	},
}
