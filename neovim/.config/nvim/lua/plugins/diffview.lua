-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
---@type LazySpec
return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"which-key.nvim",
	},
	keys = {
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
		{ "<leader>gC", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
	},
}
