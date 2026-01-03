-- Colorscheme plugins (terminal sync is handled by lua/themes/init.lua)
return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "soft",
				transparent_background_level = 2,
				on_highlights = function(hl, palette)
					-- Clear backgrounds to let Kitty transparency show through
					hl.Normal = { fg = palette.fg, bg = "NONE" }
					hl.NormalFloat = { fg = palette.fg, bg = "NONE" }
					hl.SignColumn = { fg = palette.fg, bg = "NONE" }
				end,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
		end,
	},
	{
		"everviolet/nvim",
		name = "evergarden",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.evergarden_transparent_background = true
		end,
	},
}
