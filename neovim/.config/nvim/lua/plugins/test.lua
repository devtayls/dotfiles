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

			-- Playwright's default file_pattern matches any *.spec|test.tsx anywhere,
			-- so in repos with both Playwright (e2e) and Vitest (unit) it hijacks unit
			-- tests. Require an e2e/ path segment so Vitest handles everything else.
			g["test#javascript#playwright#file_pattern"] =
				[[\v(^|/)(playwright/)?e2e/.*\.(spec|test)\.(js|jsx|ts|tsx)$]]

			-- Houston keeps vitest in assets/package.json but nvim's cwd is the repo
			-- root, so vim-test's has_package('vitest') check fails there and resolution
			-- falls through to "not a test file". Pin the runner by path instead. Also
			-- override the executable so vitest is found at assets/node_modules/.bin and
			-- --root points at assets/ for config discovery; positional file args are
			-- still resolved against nvim's cwd (repo root), which matches what vim-test
			-- emits via fnamemodify(':.').
			local houston_vitest = "assets/node_modules/.bin/vitest --root assets"
			vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
				pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
				callback = function(args)
					local path = args.file or ""
					if path:match("/playwright/e2e/") then
						g["test#javascript#runner"] = "playwright"
						g["test#javascript#vitest#executable"] = nil
					elseif path:match("/houston/") or path:match("/houston__worktrees/") then
						g["test#javascript#runner"] = "vitest"
						g["test#javascript#vitest#executable"] = houston_vitest
					else
						g["test#javascript#runner"] = nil
						g["test#javascript#vitest#executable"] = nil
					end
				end,
			})

			-- set orientation to show test runner on right side of screen
			g.VimuxOrientation = "h"

			-- set width of test panel
			g.VimuxHeight = "60"
			g.VimuxCloseOnExit = true -- Close pane when Neovim exits (avoids orphan panes)

			-- Named pane configuration - prevents conflicts with AI panes
			g.VimuxRunnerName = "tests" -- Persistent name for test pane
			g.VimuxRunnerType = "pane" -- Use pane (not window)
			g.VimuxUseNearest = 0 -- Only use our named pane, don't grab others

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

			-- Ensure vimux runner exists (reuse if already open)
			local function ensure_vimux_runner()
				if vim.fn.exists("$TMUX") == 1 then
					-- Only open if no runner exists
					if vim.g.VimuxRunnerIndex == nil then
						vim.cmd("VimuxOpenRunner")
					end
				end
			end

			-- Toggle vimux runner visibility
			local function toggle_vimux_runner()
				if vim.fn.exists("$TMUX") == 1 then
					if vim.g.VimuxRunnerIndex ~= nil then
						-- Check if pane is visible
						local pane_id = vim.g.VimuxRunnerIndex
						local is_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):match("1")

						if is_zoomed then
							-- Unzoom to show the test pane
							vim.cmd("silent !tmux resize-pane -Z")
						else
							-- Zoom main pane to hide test pane
							vim.cmd("silent !tmux resize-pane -Z")
						end
					else
						-- No runner exists, create one
						vim.cmd("VimuxOpenRunner")
					end
				end
			end

			-- Strategy for starting a runner that runs the given command on every file save
			g["test#custom_strategies"] = {
				vimux_watch = function(args)
					ensure_vimux_runner()
					vim.cmd("call VimuxClearTerminalScreen()")
					vim.cmd("call VimuxClearRunnerHistory()")
					-- Call via vim.fn so args is passed as a single Lua string; interpolating
					-- into a vimscript 'call ...' breaks on runners that shellescape file
					-- paths (e.g. vitest), since the embedded quotes close the outer string.
					vim.fn.VimuxRunCommand(string.format("fd . | entr -c %s", args))
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
			end, { desc = "run nearest test (once)" })
			map("n", "<leader>tn", function()
				ensure_vimux_runner()
				vim.cmd("TestNearest -strategy=vimux_watch")
			end, { desc = "watch nearest test" })

			map("n", "<leader>tT", function()
				ensure_vimux_runner()
				vim.cmd("TestFile")
			end, { desc = "run test file (once)" })
			map("n", "<leader>tt", function()
				ensure_vimux_runner()
				vim.cmd("TestFile -strategy=vimux_watch")
			end, { desc = "watch test file" })

			map("n", "<leader>tS", function()
				ensure_vimux_runner()
				vim.cmd("TestSuite")
			end, { desc = "run test suite (once)" })
			map("n", "<leader>ts", function()
				ensure_vimux_runner()
				vim.cmd("TestSuite -strategy=vimux_watch")
			end, { desc = "watch test suite" })

			map("n", "<leader>t.", function()
				ensure_vimux_runner()
				vim.cmd("TestLast")
			end, { desc = "run last test" })

			map("n", "<leader>tc", function()
				ensure_vimux_runner()
				vim.cmd("VimuxClearTerminalScreen")
			end, { desc = "clear test watcher" })

			-- Toggle test runner visibility (zoom/unzoom)
			map("n", "<leader>tp", toggle_vimux_runner, { desc = "toggle test pane" })

			-- Force close test runner (use sparingly)
			map("n", "<leader>tq", "<CMD>VimuxCloseRunner<CR>", { desc = "close test runner" })

			map("n", "<leader>tr", function()
				ensure_vimux_runner()
				vim.cmd("call VimuxPromptCommand()")
			end, { desc = "prompt custom command in tmux runner" })
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
