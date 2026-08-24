-- Claude runs in an external tmux pane (managed by workmux). This plugin only
-- runs the WebSocket/MCP server so Claude can `/ide` back into nvim for
-- selection context, @-mentions, and reviewable diffs. No internal terminal.
return {
	"coder/claudecode.nvim",
	event = "VeryLazy",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal = {
			provider = "none",
		},
		diff_opts = {
			open_in_current_tab = false,
			auto_close_on_accept = true,
		},
	},
	keys = {
		{ "<leader>a", nil, desc = "AI/Claude Code" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = "NvimTree",
		},
		-- Diff management
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
