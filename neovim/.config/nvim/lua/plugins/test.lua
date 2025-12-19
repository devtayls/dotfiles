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

			-- Ensure fresh vimux runner by closing and reopening
			local function ensure_vimux_runner()
				if vim.fn.exists("$TMUX") == 1 then
					-- Close existing runner to kill any running processes
					if vim.g.VimuxRunnerIndex ~= nil then
						vim.cmd("VimuxCloseRunner")
					end
					-- Open fresh runner
					vim.cmd("VimuxOpenRunner")
				end
			end

			-- Strategy for starting a runner that runs the given command on every file save
			g["test#custom_strategies"] = {
				vimux_watch = function(args)
					ensure_vimux_runner()
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

			map({ "n", "v" }, "<leader>w", function()
				ensure_vimux_runner()
				send_to_tmux()
			end, { desc = "send to tmux buffer" })

			map("n", "<leader>tN", function()
				ensure_vimux_runner()
				vim.cmd("TestNearest")
			end)
			map("n", "<leader>tn", function()
				ensure_vimux_runner()
				vim.cmd("TestNearest -strategy=vimux_watch")
			end, { desc = "run nearest test" })

			map("n", "<leader>tT", function()
				ensure_vimux_runner()
				vim.cmd("TestFile")
			end)
			map("n", "<leader>tt", function()
				ensure_vimux_runner()
				vim.cmd("TestFile -strategy=vimux_watch")
			end, { desc = "run current test file" })

			map("n", "<leader>tS", function()
				ensure_vimux_runner()
				vim.cmd("TestSuite")
			end)
			map("n", "<leader>ts", function()
				ensure_vimux_runner()
				vim.cmd("TestSuite -strategy=vimux_watch")
			end, { desc = "run test suite" })

			map("n", "<leader>t.", function()
				ensure_vimux_runner()
				vim.cmd("TestLast")
			end, { desc = "run last test" })

			map("n", "<leader>tc", function()
				ensure_vimux_runner()
				vim.cmd("VimuxClearTerminalScreen")
			end, { desc = "clear test watcher" })
			map("n", "<leader>tq", "<CMD>VimuxCloseRunner<CR>", { desc = "close test watcher" })

			map("n", "<leader>tr", function()
				ensure_vimux_runner()
				vim.cmd("call VimuxPromptCommand()")
			end)
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
					["*.js"] = {
						alternate = {
							"{}.test.js",
							"{}.spec.js",
							"__tests__/{}.js",
						},
						type = "source",
					},
					["*.test.js"] = {
						alternate = {
							"{}.js",
						},
						type = "test",
					},
					["*.spec.js"] = {
						alternate = {
							"{}.js",
						},
						type = "test",
					},
					["__tests__/*.js"] = {
						alternate = {
							"{}.js",
						},
						type = "test",
					},
					["*.tsx"] = {
						alternate = {
							"{}.test.tsx",
							"{}.spec.tsx",
							"__tests__/{}.tsx",
						},
						type = "source",
					},
					["*.test.tsx"] = {
						alternate = {
							"{}.tsx",
						},
						type = "test",
					},
					["*.spec.tsx"] = {
						alternate = {
							"{}.tsx",
						},
						type = "test",
					},
					["__tests__/*.tsx"] = {
						alternate = {
							"{}.tsx",
						},
						type = "test",
					},
				},
			}
		end,
	},
}
