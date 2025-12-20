-- Evergarden theme configuration
local M = {}

M.colorscheme = "evergarden"

function M.setup()
  require("evergarden").setup({
    transparent_background = true, -- Use transparent background (shows terminal background)
    contrast_dark = "medium", -- 'hard'|'medium'|'soft'
    override_terminal = true, -- Override terminal colors
    style = {
      tabline = { reverse = true, color = "green" },
      search = { reverse = false, inc_reverse = true },
      types = { italic = true },
      keyword = { italic = true },
      comment = { italic = true },
    },
    overrides = {}, -- Add custom highlights here
  })
end

-- Return the plugin spec for inclusion in plugin lists
M.plugin_spec = {
  "everviolet/nvim",
  name = "evergarden",
  lazy = false,
  priority = 1000,
  config = function()
    -- This will be handled by the theme system
  end,
}

return M
