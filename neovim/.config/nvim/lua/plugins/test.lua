return {
	{
		"janko/vim-test",
		dependencies = {
			"tpope/vim-dispatch",
			"neomake/neomake",
			"preservim/vimux",
			"vim-projectionist",
			"which-key.nvim",
		},
		config = function()
			local g = vim.g
			local v = vim.v

			-- set orientation to show test runner on right side of screen
			g.VimuxOrientation = "h"

			-- set width of test panel
			g.VimuxHeight = "60"
			g.VimuxCloseOnExit = true

			local send_to_tmux = function()
				-- yank text into v register
				if vim.api.nvim_get_mode()["mode"] == "n" then
					vim.cmd('normal vip"vy')
				else
					vim.cmd('normal "vy')
				end
				-- construct command with v register as command to send
				-- vim.cmd(string.format('call VimuxRunCommand("%s")', vim.trim(vim.fn.getreg('v'))))
				vim.cmd("call VimuxRunCommand(@v)")
			end

			-- Strategy for starting a runner that runs the given command on every file save
			g["test#custom_strategies"] = {
				vimux_watch = function(args)
					vim.cmd("call VimuxClearTerminalScreen()")
					vim.cmd("call VimuxClearRunnerHistory()")
					vim.cmd(string.format("call VimuxRunCommand('fd . | entr -c %s')", args))
				end,
			}

			local map = vim.keymap.set

			local wk = require("which-key")
			wk.add({
				{ "<leader>t", group = "+test" },
			})

			map({ "n", "v" }, "<leader>w", send_to_tmux, { desc = "send to tmux buffer" })

			map("n", "<leader>tN", "<CMD>TestNearest<CR>")
			map("n", "<leader>tn", "<CMD>TestNearest -strategy=vimux_watch<CR>", { desc = "run nearest test" })

			map("n", "<leader>tT", "<CMD>TestFile<CR>")
			map("n", "<leader>tt", "<CMD>TestFile -strategy=vimux_watch<CR>", { desc = "run current test file" })

			map("n", "<leader>tS", "<CMD>TestSuite<CR>")
			map("n", "<leader>ts", "<CMD>TestSuite -strategy=vimux_watch<CR>", { desc = "run test suite" })

			map("n", "<leader>t.", "<CMD>TestLast<CR>", { desc = "run last test" })

			map("n", "<leader>tc", "<CMD>VimuxClearTerminalScreen<CR>", { desc = "clear test watcher" })
			map("n", "<leader>tq", "<CMD>VimuxCloseRunner<CR>", { desc = "close test watcher" })

			map("n", "<leader>tr", "<CMD>call VimuxPromptCommand()<CR>")
			map("n", "<leader>tv", "<CMD>TestVisit<CR>zz", { desc = "visit last test" })

			-- Use Projectionist to jump to related test<>code file
			map("n", "<leader>t<backspace>", "<CMD>:A<CR>", { desc = "toggle buffer for test file" })

			g["test#strategy"] = {
				nearest = "vimux",
				file = "vimux",
				suite = "vimux",
			}
		end,
	},
	{
		"tpope/vim-projectionist",
		init = function()
			vim.g.projectionist_heuristics = {
				["*"] = {
					["*.ex"] = {
						alternate = {
							"{}_test.exs",
						},
						type = "source",
					},
					["*_test.exs"] = {
						alternate = {
							"{}.ex",
						},
					},
				},
			}
		end,
	},
}
