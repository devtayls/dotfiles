-- Simplified theme system that syncs terminal themes with Neovim colorscheme changes
local M = {}

-- Map Neovim colorscheme names to terminal theme names (when they differ)
local colorscheme_to_terminal_theme = {
  dayfox = "dayfox",
  nightfox = "nightfox",
  carbonfox = "carbonfox",
  terafox = "terafox",
  nordfox = "nordfox",
  duskfox = "duskfox",
  dawnfox = "dawnfox",
  everforest = "everforest",
  evergarden = "evergarden-spring",
  material = "material",
  ["rose-pine"] = "rose-pine",
  ["rose-pine-moon"] = "rose-pine-moon",
  ["rose-pine-dawn"] = "rose-pine-dawn",
  -- Add more mappings as needed
}

-- Sync terminal theme when Neovim colorscheme changes
local function sync_terminal_theme(colorscheme)
  local terminal_theme = colorscheme_to_terminal_theme[colorscheme] or colorscheme

  -- Switch Kitty theme (only if theme file exists)
  local kitty_themes_dir = vim.fn.expand("~/dotfiles/kitty/.config/kitty/themes")
  local kitty_theme_file = kitty_themes_dir .. "/" .. terminal_theme .. ".conf"

  if vim.fn.filereadable(kitty_theme_file) == 1 then
    local kitty_script = vim.fn.expand("~/dotfiles/kitty/.config/kitty/switch-theme.sh")
    if vim.fn.filereadable(kitty_script) == 1 then
      if vim.system then
        vim.system({ kitty_script, terminal_theme }, { text = true }, function(obj)
          if obj.code ~= 0 then
            vim.schedule(function()
              vim.notify("Failed to switch Kitty theme: " .. (obj.stderr or obj.stdout or ""), vim.log.levels.WARN)
            end)
          end
        end)
      else
        -- Fallback for older Neovim versions
        local cmd = string.format("'%s' '%s' >/dev/null 2>&1 &", kitty_script, terminal_theme)
        os.execute(cmd)
      end
    end
  end

  -- Switch Ghostty theme (only if theme file exists)
  local ghostty_themes_dir = vim.fn.expand("~/dotfiles/ghostty/.config/ghostty/themes")
  local ghostty_theme_file = ghostty_themes_dir .. "/" .. terminal_theme

  if vim.fn.isdirectory(ghostty_theme_file) == 1 or vim.fn.filereadable(ghostty_theme_file) == 1 then
    local ghostty_script = vim.fn.expand("~/dotfiles/ghostty/.config/ghostty/switch-theme.sh")
    if vim.fn.filereadable(ghostty_script) == 1 then
      if vim.system then
        vim.system({ ghostty_script, terminal_theme }, { text = true }, function(obj)
          if obj.code ~= 0 then
            vim.schedule(function()
              vim.notify("Failed to switch Ghostty theme: " .. (obj.stderr or obj.stdout or ""), vim.log.levels.WARN)
            end)
          end
        end)
      else
        -- Fallback for older Neovim versions
        local cmd = string.format("'%s' '%s' >/dev/null 2>&1 &", ghostty_script, terminal_theme)
        os.execute(cmd)
      end
    end
  end

  -- Switch Tmux theme (only if theme file exists)
  local tmux_themes_dir = vim.fn.expand("~/dotfiles/tmux/.config/tmux/themes")
  local tmux_theme_file = tmux_themes_dir .. "/" .. terminal_theme .. ".conf"

  if vim.fn.filereadable(tmux_theme_file) == 1 then
    local tmux_script = vim.fn.expand("~/dotfiles/tmux/.config/tmux/switch-theme.sh")
    if vim.fn.filereadable(tmux_script) == 1 then
      if vim.system then
        vim.system({ tmux_script, terminal_theme }, { text = true }, function(obj)
          if obj.code ~= 0 then
            vim.schedule(function()
              vim.notify("Failed to switch Tmux theme: " .. (obj.stderr or obj.stdout or ""), vim.log.levels.WARN)
            end)
          end
        end)
      else
        -- Fallback for older Neovim versions
        local cmd = string.format("'%s' '%s' >/dev/null 2>&1 &", tmux_script, terminal_theme)
        os.execute(cmd)
      end
    end
  end
end

-- Initialize the theme sync system
function M.init()
  -- Auto-sync terminal theme when colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ThemeSync", { clear = true }),
    callback = function(args)
      sync_terminal_theme(args.match)
    end,
    desc = "Sync terminal theme with Neovim colorscheme",
  })

  -- Create user command for manual theme picker
  vim.api.nvim_create_user_command("ThemePicker", function()
    require("telescope.builtin").colorscheme({ enable_preview = true })
  end, {
    desc = "Open Telescope colorscheme picker with live preview",
  })

  -- Create command to show current themes
  vim.api.nvim_create_user_command("CurrentTheme", function()
    local nvim_theme = vim.g.colors_name or "unknown"
    local themes = { "Neovim: " .. nvim_theme }

    -- Get Kitty theme
    local kitty_script = vim.fn.expand("~/dotfiles/kitty/.config/kitty/switch-theme.sh")
    if vim.fn.filereadable(kitty_script) == 1 then
      vim.system({ kitty_script, "current" }, { text = true }, function(kitty_obj)
        local kitty_theme = kitty_obj.stdout and vim.trim(kitty_obj.stdout) or "unknown"
        table.insert(themes, "Kitty: " .. kitty_theme)

        -- Get Tmux theme
        local tmux_script = vim.fn.expand("~/dotfiles/tmux/.config/tmux/switch-theme.sh")
        if vim.fn.filereadable(tmux_script) == 1 then
          vim.system({ tmux_script, "current" }, { text = true }, function(tmux_obj)
            vim.schedule(function()
              local tmux_theme = tmux_obj.stdout and vim.trim(tmux_obj.stdout) or "unknown"
              table.insert(themes, "Tmux: " .. tmux_theme)
              vim.notify(table.concat(themes, "\n"), vim.log.levels.INFO)
            end)
          end)
        else
          vim.schedule(function()
            vim.notify(table.concat(themes, "\n"), vim.log.levels.INFO)
          end)
        end
      end)
    else
      vim.notify(table.concat(themes, "\n"), vim.log.levels.INFO)
    end
  end, {
    desc = "Show current Neovim, Kitty, and Tmux themes",
  })

  -- Keybinding
  vim.keymap.set("n", "<leader>t/", function()
    require("telescope.builtin").colorscheme({ enable_preview = true })
  end, { desc = "Colorscheme Picker (Telescope)" })

  -- Set default colorscheme
  vim.cmd.colorscheme("everforest")
end

return M
