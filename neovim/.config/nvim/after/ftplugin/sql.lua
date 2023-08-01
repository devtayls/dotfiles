local keymap = vim.keymap

keymap.set("n", "<leader>\\", "<CMD>DBUIToggle<CR>", { buffer = true })
-- visually select the area under the cursor and run the query
keymap.set("n", "<leader>r", ":normal vip<CR><PLUG>(DBUI_ExecuteQuery)", { buffer = true })
