-- Nightfox theme configuration
local M = {}

M.colorscheme = "dayfox"

function M.setup()
	require("nightfox").setup({
		options = {
			-- Compiled file's destination location
			compile_path = vim.fn.stdpath("cache") .. "/nightfox",
			compile_file_suffix = "_compiled", -- Compiled file suffix
			transparent = true, -- Enable transparent background (shows Kitty's light background)
			terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
			dim_inactive = false, -- Non focused panes set to alternative background
			module_default = true, -- Default enable value for modules
			colorblind = {
				enable = false, -- Enable colorblind support
				simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
				severity = {
					protan = 0, -- Severity [0,1] for protan (red)
					deutan = 0, -- Severity [0,1] for deutan (green)
					tritan = 0, -- Severity [0,1] for tritan (blue)
				},
			},
			styles = { -- Style to be applied to different syntax groups
				comments = "italic", -- Value is any valid attr-list value `:help attr-list`
				conditionals = "NONE",
				constants = "NONE",
				functions = "NONE",
				keywords = "NONE",
				numbers = "NONE",
				operators = "NONE",
				strings = "NONE",
				types = "NONE",
				variables = "NONE",
			},
			inverse = { -- Inverse highlight for different types
				match_paren = false,
				visual = false,
				search = false,
			},
		},
		palettes = {},
		specs = {},
		groups = {},
	})
end

-- Return the plugin spec for inclusion in plugin lists
M.plugin_spec = {
	"EdenEast/nightfox.nvim",
	config = function()
		-- This will be handled by the theme system
	end,
}

return M

