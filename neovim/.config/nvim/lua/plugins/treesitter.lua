return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
				init = function()
					vim.g.no_plugin_maps = true
				end,
			},
		},
		config = function()
			local parsers = {
				-- Core neovim
				"lua",
				"vim",
				"vimdoc",
				"query",
				-- Primary languages
				"elixir",
				"heex",
				"eex",
				-- JavaScript/TypeScript
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				-- Config/Data formats
				"json",
				"jsonc",
				"yaml",
				"toml",
				"terraform",
				-- Shell/System
				"bash",
				"dockerfile",
				-- Markup/Documentation
				"markdown",
				"markdown_inline",
				"html",
				"css",
				-- Git
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				-- SQL
				"sql",
			}

			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					local lang = vim.treesitter.language.get_lang(ft)
					if not lang then
						return
					end
					if not pcall(vim.treesitter.start, args.buf, lang) then
						return
					end
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			local function sel(obj)
				return function()
					select.select_textobject(obj, "textobjects")
				end
			end

			-- Select
			vim.keymap.set({ "x", "o" }, "ic", sel("@comment.inner"))
			vim.keymap.set({ "x", "o" }, "ac", sel("@comment.outer"))
			vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"))
			vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"))
			vim.keymap.set({ "x", "o" }, "am", sel("@class.outer"))
			vim.keymap.set({ "x", "o" }, "im", sel("@class.inner"))
			vim.keymap.set({ "x", "o" }, "ib", sel("@block.inner"))
			vim.keymap.set({ "x", "o" }, "ab", sel("@block.outer"))
			vim.keymap.set({ "x", "o" }, "a,", sel("@parameter.outer"))
			vim.keymap.set({ "x", "o" }, "i,", sel("@parameter.inner"))

			-- Move
			vim.keymap.set({ "n", "x", "o" }, "]]", function()
				move.goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "],", function()
				move.goto_next_start("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "][", function()
				move.goto_next_end("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[[", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[,", function()
				move.goto_previous_start("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[]", function()
				move.goto_previous_end("@function.outer", "textobjects")
			end)
		end,
	},
}
