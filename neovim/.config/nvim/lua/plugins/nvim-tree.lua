return {
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	keys = {
		{ "<leader>e", ":NvimTreeFindFileToggle<cr>", desc = "Open file tree at location" },
		{ "<leader>E", ":NvimTreeToggle<cr>", desc = "Open file tree at root" },
	},
	config = true,
}
