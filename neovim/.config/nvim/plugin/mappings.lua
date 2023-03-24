vim.keymap.set('n', '<escape>', ':nohlsearch <cr>')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
--Flip keys in normal and visual mode, so that shift isn't required for colon commands
--vim.keymap.set({'n', 'v'}, ';', ':')
--vim.keymap.set({'n', 'v'}, ':', ';')
--Remap arros keys so they aren't a crutch
vim.keymap.set('n', '<UP>', '<CMD>cope<CR>')
vim.keymap.set('n', '<DOWN>', '<CMD>cclose<CR>')
vim.keymap.set('n', '<RIGHT>', '<CMD>cnext<CR>')
vim.keymap.set('n', '<LEFT>', '<CMD>cprev<CR>')
vim.keymap.set('n', '<BS>', '<CMD>b#<CR>')
