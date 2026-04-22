return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
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
