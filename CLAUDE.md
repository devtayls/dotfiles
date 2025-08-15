# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository that manages configuration files for various development tools using GNU Stow for symlink management. The configuration follows the XDG Base Directory specification where possible and uses conventional commit message standards with GPG signing.

## Common Commands

### Primary dotfiles management
- `dots` - Install Brewfile packages and stow all dotfiles (default action)
- `dots install` - Install Homebrew packages from Brewfile only
- `dots stow` - Stow all dotfiles using `stow --no-folding */`
- `dots edit` - Edit the dots script itself

### Security and validation
- `gitleaks git --pre-commit --redact --staged --verbose --no-banner` - Check for secrets (runs via lefthook pre-commit hook)
- Pre-commit hooks are configured in `lefthook.yml` and run automatically

### Neovim plugin management
- `nvim "+Lazy sync"` - Install/update all Neovim plugins
- `:Lazy` - Open lazy.nvim plugin manager interface

## Architecture and Structure

### Dotfiles Organization
Each tool has its own top-level directory following stow-compatible structure:
- `neovim/` - Neovim configuration based on base.nvim template
- `tmux/` - Tmux configuration with custom plugins and keybindings
- `zsh/` - Zsh configuration with oh-my-zsh and powerlevel10k
- `git/` - Git configuration and global gitignore
- `kitty/` - Kitty terminal emulator configuration
- `karabiner/` - Karabiner-Elements keyboard customization
- `ghostty/` - Ghostty terminal emulator configuration
- `lsd/` - LSD (ls deluxe) configuration
- `dots/` - Custom dotfiles management script

### Neovim Configuration Architecture
Based on base.nvim template with modular plugin system:
- `init.lua` - Entry point that loads options and lazy.nvim
- `lua/options.lua` - Neovim settings and options
- `lua/plugins/` - Plugin configurations (lazy.nvim auto-loads all files)
- `plugin/` - Auto-loaded custom configurations (mappings, diagnostics, etc.)
- `after/ftplugin/` - Filetype-specific configurations loaded after plugins

Key plugins include:
- Language servers for Elixir, Lua, and other languages
- Telescope for fuzzy finding
- Treesitter for syntax highlighting
- Various editing and UI enhancements

### Tmux Configuration
- Custom status bar with powerline-style formatting
- Vim-style keybindings and navigation
- Integration with fzf, gh CLI, and other tools
- Session management with rally and smug templates
- Plugin system using TPM (Tmux Plugin Manager)

### Package Management
- `Brewfile` - Homebrew bundle file managing all system packages
- Includes taps for specialized tools (Cloudflare, HashiCorp, QMK, etc.)
- Covers development tools, languages, and GUI applications

## Development Guidelines

### Code Style
- **Lua (Neovim)**: 2-space indentation, snake_case variables, use `vim.opt` for options
- **Shell scripts**: Use `#!/bin/bash`, explicit error handling with case statements
- **YAML**: 2-space indentation for configuration files
- **Git**: Conventional commit messages, GPG signing required, rebase workflow

### Security Requirements
- All commits must be GPG signed
- Gitleaks pre-commit hook prevents secret leaks
- Use environment variables for sensitive data, never hardcode secrets

### File Management
- Follow XDG Base Directory specification
- Use stow-compatible structure with configs in subdirectories
- After adding new configuration files, run `dots stow` to update symlinks
- Preserve existing file structure when making changes

### Tmux Session Templates
- Session configurations stored in `tmux/.config/smug/`
- Use smug for project-specific tmux layouts
- Templates include: default, dotfiles, portal, houston, balenciauthga, devhub

## Formatting Tools
- Lua: stylua (configured in conform.nvim)
- JavaScript/TypeScript: prettier  
- Elixir: mix format
- Terraform: terraform_fmt