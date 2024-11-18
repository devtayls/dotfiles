return {
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
			"which-key.nvim",
		},

		keys = {
			-- Open fugitive
			{ "<leader>gg", "<CMD>G<CR>", desc = "fugitive" },
			-- Open quicklist with git log
			{ "<leader>gl", "<CMD>Gclog<CR>", desc = "log" },
			-- Open buffer with git history
			{ "<leader>gh", "<CMD>0Gclog<CR>", desc = "history" },
			-- Open side panel with git blame by line
			{ "<leader>gb", "<CMD>Git blame<CR>", desc = "blame" },
			-- Open diff in buff
			{ "<leader>gd", "<CMD>Gdiff<CR>", desc = "open buffer diff" },
			{ "<leader>gw", "<CMD>Gwrite<CR>", desc = "write" },
			{ "<leader>gr", "<CMD>Gread<CR>", desc = "read" },
		},
		config = function()
			-- Put things in quick list
			vim.keymap.set("n", "<leader>gw", "<CMD>Git difftool --name-only<CR>")
			vim.keymap.set("n", "<leader>gW", "<CMD>Git difftool<CR>")

			-- use arrows to put / get hunks in diff views
			vim.keymap.set("n", "<leader>g<left>", "<CMD>diffget<CR>")
			vim.keymap.set("n", "<leader>g<right>", "<CMD>diffget<CR>")
			vim.keymap.set("n", "<leader>g<down>", "<CMD>diffput<CR>")
			vim.keymap.set("v", "<leader>g<down>", "<CMD>diffput<CR><ESC>")
		end,
	},
	{
		"rhysd/git-messenger.vim",
		lazy = true,
		keys = { { "<leader>gm", "<CMD>GitMessenger<CR>", desc = "Git message" } },
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"which-key.nvim",
		},
		config = function()
			local gitsigns = require("gitsigns")

			local function next_hunk()
				-- Move to next hunk
				gitsigns.next_hunk()
				-- center cursor
				vim.cmd("normal zz")
			end

			local function prev_hunk()
				-- Move to prev hunk
				gitsigns.prev_hunk()
				-- center cursor
				vim.cmd("normal zz")
			end

			gitsigns.setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "│" },
					topdelete = { text = "│" },
					changedelete = { text = "│" },
				},
				on_attach = function(bufnr)
					local map = vim.keymap.set
					local opts = { silent = true }
				end,
			})

			local wk = require("which-key")
			wk.add({
				{ "<leader>g", group = "+git" },
				{ "]g", next_hunk, { desc = "next hunk" } },
				{ "[g", prev_hunk, { desc = "prev hunk" } },
				{ "<leader>g+", gitsigns.stage_hunk, desc = "stage hunk" },
				{ "<leader>g-", gitsigns.undo_stage_hunk, desc = "unstage hunk" },
				{ "<leader>g=", gitsigns.reset_hunk, desc = "reset hunk" },
				{ "<leader>gp", gitsigns.preview_hunk, desc = "preview changes" },
			})
		end,
	},
	"sindrets/diffview.nvim",
}
