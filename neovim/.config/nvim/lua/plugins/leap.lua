return {
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
}
