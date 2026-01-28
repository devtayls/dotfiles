# Dotfiles TODO

## LazyVim Migration

### Overview
Created a second Neovim instance using LazyVim distribution for experimentation and customization alongside the existing base.nvim setup.

### File Locations

**Dotfiles Source:**
- Configuration: `dotfiles/neovim-lazy/.config/nvim-lazy/`
- Wrapper Script: `dotfiles/neovim-lazy/.local/bin/nvim-lazy`

**Stowed Locations (Active):**
- Config: `~/.config/nvim-lazy/`
- Script: `~/.local/bin/nvim-lazy`
- Data/Plugins: `~/.local/share/nvim-lazy/`
- State: `~/.local/state/nvim-lazy/`
- Cache: `~/.cache/nvim-lazy/`

**Alias:**
- Added to `zsh/.zshrc:128`: `alias nvim-lazy='~/.local/bin/nvim-lazy'`

### Usage

```bash
# Launch LazyVim instance
nvim-lazy

# Or with a file
nvim-lazy myfile.txt

# Original nvim remains unchanged
nvim  # Still uses ~/.config/nvim/
```

### How It Works

The `nvim-lazy` wrapper script sets `NVIM_APPNAME=nvim-lazy`, which tells Neovim to use:
- `~/.config/nvim-lazy/` for configuration
- `~/.local/share/nvim-lazy/` for plugins/data
- Completely isolated from the main nvim instance

### Next Steps

- [ ] Launch `nvim-lazy` for the first time (plugins will auto-install)
- [ ] Explore LazyVim keybindings (leader key is `<Space>`)
- [ ] Review LazyVim plugins in `lua/plugins/` directory
- [ ] Customize colorscheme (default is tokyonight)
- [ ] Add custom keybindings in `lua/config/keymaps.lua`
- [ ] Configure LSP servers in `lua/config/lazy.lua`
- [ ] Compare with current base.nvim setup
- [ ] Decide which plugins/features to port over
- [ ] Consider migrating fully or keeping both setups

### LazyVim Resources

- Documentation: https://www.lazyvim.org/
- Keymaps: https://www.lazyvim.org/keymaps
- Plugins: https://www.lazyvim.org/plugins
- Configuration: https://www.lazyvim.org/configuration

### Original Setup (Unchanged)

- Location: `dotfiles/neovim/.config/nvim/`
- Active at: `~/.config/nvim/`
- Based on: base.nvim template
- Launch with: `nvim`
