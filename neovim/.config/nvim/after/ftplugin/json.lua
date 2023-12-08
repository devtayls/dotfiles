local keymap = vim.keymap

keymap.set("n", "<localleader>lf", ":%! jq<CR>", { buffer = true })
keymap.set("v", "<localleader>lf", ":! jq<CR>", { buffer = true })
