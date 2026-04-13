# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository using **GNU Stow** for symlink management. Configuration follows XDG Base Directory spec where possible and uses conventional commits with GPG signing.

## Common Commands

### Dotfiles management
- `dots` - Install Brewfile packages and stow all dotfiles (default action)
- `dots install` - Install Homebrew packages from Brewfile only
- `dots stow` - Stow all dotfiles using `stow --no-folding */`

### Neovim
- `nvim "+Lazy sync"` - Install/update all Neovim plugins
- `:Lazy` - Open lazy.nvim plugin manager interface

## Architecture

### How Stow Works
This repository uses **GNU Stow** to manage dotfiles via symlinks:

**Repository:** `~/dotfiles/`

**Stow Behavior:**
- Each top-level directory is a "stow package" (e.g., `neovim/`, `tmux/`, `zsh/`)
- Running `dots stow` (runs `stow --no-folding */`) symlinks ALL packages at once
- Package directory names are stripped during symlinking

**Examples:**
```
~/dotfiles/neovim/.config/nvim/init.lua  →  ~/.config/nvim/init.lua
~/dotfiles/zsh/.zshrc                    →  ~/.zshrc
~/dotfiles/git/.config/git/gitignore     →  ~/.config/git/gitignore
```

**Important:** When editing dotfiles, you're editing files in `~/dotfiles/`. Files in `~/.config` are symlinks pointing back to this repo.

### Dotfiles Organization
Top-level directories (stow packages):
- `neovim/` - Neovim config (base.nvim template, lazy.nvim plugin manager)
- `tmux/` - Tmux with custom plugins and keybindings
- `zsh/` - Zsh with oh-my-zsh and powerlevel10k
- `git/` - Git configuration and global gitignore
- `ghostty/` - Ghostty terminal emulator (current terminal)
- `karabiner/` - Karabiner-Elements keyboard customization
- `mise/` - Mise version manager configuration
- `dots/` - Custom dotfiles management script

### Package Management
**Critical: Homebrew vs mise separation**

- **Homebrew (`Brewfile`)** - System packages, CLI tools, GUI apps
  - Does NOT include language runtimes (Elixir, Node, etc.)
  - Run `dots install` or `brew bundle install` to sync

- **mise** - Version manager for language runtimes
  - Global: `mise/.config/mise/config.toml`
  - Per-project: `.mise.toml` files
  - Manages: Elixir, Erlang, Node, Python, Go, etc.
  - Replaces: asdf, nvm, rbenv, pyenv

### Version Management (Non-obvious!)
- **Elixir & Erlang:** Managed by **mise**, NOT Homebrew (removed from Brewfile)
- **ElixirLS:** Auto-managed by **elixir-tools.nvim** plugin, NOT Homebrew
- **Node, Python, Go:** Managed by mise per-project

## Development Guidelines

### Security Requirements
- All commits must be GPG signed
- Gitleaks pre-commit hook prevents secret leaks (configured in `lefthook.yml`)
- Use environment variables for sensitive data

### File Management
- All dotfiles live in `~/dotfiles/`, organized by tool in top-level directories
- After adding new files in `~/dotfiles/<package>/`, run `dots stow`
- Edit files in `~/dotfiles/` OR via symlinks in `~` (both work)
- Follow XDG Base Directory spec (configs in `.config/` when possible)

### Code Style
- **Lua (Neovim)**: 2-space indentation, snake_case, use `vim.opt`
- **Shell scripts**: `#!/bin/bash`, explicit error handling
- **Git**: Conventional commits, GPG signing, rebase workflow