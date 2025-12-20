-- Everforest theme configuration
local M = {}

M.colorscheme = "everforest"

function M.setup()
  -- Plugin specification (for lazy.nvim)
  local plugin_spec = {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup({
        ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
        ---Default is "medium".
        background = "soft",
        ---How much of the background should be transparent. 2 will have more UI
        ---components be transparent (e.g. status line background)
        transparent_background_level = 2,
        on_highlights = function(highlight_groups, palette) end,
      })
    end,
  }
  
  -- If lazy.nvim is available, ensure plugin is installed
  if package.loaded.lazy then
    require("lazy").load({ plugins = { "everforest-nvim" } })
  end
  
  -- Setup everforest
  require("everforest").setup({
    background = "soft",
    transparent_background_level = 2,
    on_highlights = function(highlight_groups, palette) end,
  })
end

-- Return the plugin spec for inclusion in plugin lists
M.plugin_spec = {
  "neanias/everforest-nvim",
  config = function()
    -- This will be handled by the theme system
  end,
}

return M