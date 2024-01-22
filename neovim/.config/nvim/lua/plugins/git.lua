return {
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
		},
		config = function()
			-- Open pane displaying changed files
			vim.keymap.set("n", "<leader>gg", "<CMD>G<CR>")
			vim.keymap.set("n", "<leader>gl", "<CMD>Gclog<CR>")
			vim.keymap.set("n", "<leader>gh", "<CMD>0Gclog<CR>")
			vim.keymap.set("n", "<leader>gb", "<CMD>Git blame<CR>")
			vim.keymap.set("n", "<leader>gd", "<CMD>Gdiff<CR>")
			vim.keymap.set("n", "<leader>gw", "<CMD>Gwrite<CR>")
			vim.keymap.set("n", "<leader>gr", "<CMD>Gread<CR>")
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
		keys = { { "<leader>gm", "<CMD>GitMessenger<CR>", description = "Git message" } },
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"which-key.nvim",
		},
		config = function()
			local gitsigns = require("gitsigns")

			function next_hunk()
				-- Move to next hunk
				gitsigns.next_hunk()
				-- center cursor
				vim.cmd("normal zz")
			end

			function prev_hunk()
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

					-- map('n', ']g', next_hunk, opts)
					-- map('n', '[g', prev_hunk, opts)
					-- map('n', '<leader>g+', gitsigns.stage_hunk, opts)
					-- map('n', '<leader>g-', gitsigns.undo_stage_hunk, opts)
					-- map('n', '<leader>g=', gitsigns.reset_hunk, opts)
					-- map('n', '<leader>gp', gitsigns.preview_hunk, opts)
				end,
			})

			local wk = require("which-key")

			wk.register({
				["<leader>g"] = { name = "+git" },
				["<leader>g+"] = { gitsigns.stage_hunk, "Stage Hunk" },
				["<leader>g-"] = { gitsigns.undo_stage_hunk, "Unstage Hunk" },
				["<leader>g="] = { gitsigns.reset_hunk, "Reset Hunk" },
				["<leader>gp"] = { gitsigns.preview_hunk, "Show Changes" },
			})
		end,
	},
}
