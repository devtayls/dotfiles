# Agent Guidelines for Dotfiles Repository

## Build/Test/Lint Commands
- `dots` - Main command to install Brewfile and stow dotfiles
- `dots install` - Install Homebrew packages from Brewfile
- `dots stow` - Stow all dotfiles using `stow --no-folding */`
- `gitleaks git --pre-commit --redact --staged --verbose --no-banner` - Check for secrets (via lefthook)
- No traditional test suite - this is a dotfiles configuration repository

## Code Style Guidelines
- **Lua (Neovim)**: 2-space indentation, snake_case for variables, use `vim.opt` for options
- **Shell scripts**: Use `#!/bin/bash`, prefer explicit error handling with case statements
- **YAML**: 2-space indentation for configuration files
- **Git**: Use conventional commit messages, GPG signing enabled, rebase workflow preferred

## File Organization
- Each tool has its own directory (neovim/, tmux/, zsh/, etc.)
- Use stow-compatible structure with dotfiles in subdirectories
- Configuration files follow XDG Base Directory specification where possible
- Keep tool-specific configs in `.config/` subdirectories

## Formatting Tools
- Lua: stylua (configured in conform.nvim)
- JavaScript/TypeScript: prettier
- Elixir: mix format
- Terraform: terraform_fmt

## Security
- All commits are GPG signed
- Gitleaks pre-commit hook prevents secret leaks
- Use environment variables for sensitive data, never hardcode secrets