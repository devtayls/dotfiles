vim.keymap.set("n", "<escape>", ":nohlsearch <cr>")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")
--Flip keys in normal and visual mode, so that shift isn't required for colon commands
--vim.keymap.set({'n', 'v'}, ';', ':')
--vim.keymap.set({'n', 'v'}, ':', ';')
--Remap arros keys so they aren't a crutch
vim.keymap.set("n", "<UP>", "<CMD>copen<CR>")
vim.keymap.set("n", "<DOWN>", "<CMD>cclose<CR>")
vim.keymap.set("n", "<RIGHT>", "<CMD>cnext<CR>")
vim.keymap.set("n", "<LEFT>", "<CMD>cprev<CR>")
vim.keymap.set("n", "<BS>", "<CMD>b#<CR>")

-- Select in visual mode, then copy to system keyboard
vim.keymap.set("v", "<leader>cc", '"+y', { desc = "copy to system clipboard" })

-- Paste from the keyboard in normal mode
vim.keymap.set("n", "<leader>vv", '"+p', { desc = "paste from system clipboard" })

-- Put the latest yanked, persists over change and delete ops by using the 0th register
vim.keymap.set('n', 'P', '"0p', { desc = "paste from yank register" })
