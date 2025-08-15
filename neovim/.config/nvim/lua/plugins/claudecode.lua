return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal = {
			snacks_win_opts = {
				keys = {
					claude_hide_esc = {
						"<C-\\>",
						function(self)
							self:hide()
						end,
						mode = "t",
						desc = "Hide (Ctrl+\\)",
					},
				},
			},
		},
	},
	keys = {
		{ "<leader>a", nil, desc = "AI/Claude Code" },
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
		},
		-- Diff management
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
-- snacks wasn't happy:
-- return {
-- 	"coder/claudecode.nvim",
-- 	lazy = false,
-- 	dependencies = { "folke/snacks.nvim" },
-- 	opts = {
-- 		editor = "nvim",
-- 		terminal = {
-- 			auto_close = true, -- Auto-close when Claude exits
-- 		},
-- 		diff_opts = {
-- 			auto_close_on_accept = true, -- Close diff after accepting
-- 		},
-- 	},
-- 	config = function()
-- 		-- Disable snacks.nvim features that might interfere
-- 		require("snacks").setup({
-- 			bigfile = { enabled = true },
-- 			notifier = { enabled = false },
-- 			quickfile = { enabled = true },
-- 			statuscolumn = { enabled = false },
-- 			words = { enabled = false },
-- 			-- Disable any breadcrumb/winbar features
-- 			breadcrumbs = { enabled = false },
-- 			scope = { enabled = false },
-- 		})
-- 	end,
-- 	keys = {
-- 		-- Core functionality
-- 		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
-- 		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
-- 		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
-- 		{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },

-- 		-- Context management
-- 		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
-- 		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
-- 		{ "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file", ft = { "oil" } },

-- 		-- Diff management
-- 		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
-- 		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
-- 	},
-- }
