return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"RRethy/nvim-treesitter-endwise",
		},
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
			ensure_installed = {
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
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["ic"] = "@comment.inner",
						["ac"] = "@comment.outer",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["am"] = "@class.outer",
						["im"] = "@class.inner",
						["ib"] = "@block.inner",
						["ab"] = "@block.outer",
						["a,"] = "@parameter.outer",
						["i,"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]]"] = "@function.outer",
						["],"] = "@parameter.inner",
					},
					goto_next_end = {
						["]["] = "@function.outer",
					},
					goto_previous_start = {
						["[["] = "@function.outer",
						["[,"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[]"] = "@function.outer",
					},
				},
			},
			endwise = {
				enable = true,
			},
		})
		end,
	},
}
