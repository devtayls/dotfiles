--[[
┌────────────────────────────┐
│░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀│
│░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█│
│░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀│
└────────────────────────────┘

A place to set Neovim options.

Neovim has a lot of options to affect editor behavior. Things like showing line
numbers, converting tabs to spaces, etc. All of them can be seen at `:help
option-summary`.

For any option shown below you can get to its docs directly by typing its name
in quotes. For example:

vim.opt.number = true

`:help 'number'`
--]]

-- show line numbers
vim.opt.number = true
-- use 24-bit RGB colors (your terminal must support this to work - most modern ones do)
vim.opt.termguicolors = true
-- how many spaces should a tab be
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- The "Leader key" is a way of extending the power of VIM's shortcuts by using sequences of keys to perform a command.
-- The default leader key is backslash. Therefore, if you have a map of <Leader>Q, you can perform that action by typing \Q.
-- see `:help <leader>`
vim.g.mapleader = " "

-- The "Local Leader" key is a way defining a seperate behaviour on a per-file-type basis
-- see `:help <localleader>`
vim.g.maplocalleader = " m"

-- Searching
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- grep
if vim.fn.executable("rg") then
	vim.o.grepprg = "rg --vimgrep --hidden -g !.git"
end

-- column management
vim.opt.signcolumn = "yes"

-- hide mode text in command bar
vim.opt.showmode = false

-- enable cursonline
vim.opt.cursorline = true

-- Enable statusline on always and only the last window
vim.opt.laststatus = 3

-- Spell checking, set for cmp-spell
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
