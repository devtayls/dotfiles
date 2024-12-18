local keymap = vim.keymap

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.ex", ".heex", ".exs" },
-- 	callback = function()
-- 		vim.cmd("%! mix format --dry-run <CR>")
-- 	end,
-- })

-- keymap.set("n", "<localleader>lf", ":%! mix format<CR>", { buffer = true })
-- keymap.set("v", "<localleader>lf", ":! mix format<CR>", { buffer = true })
-- keymap.set("v", "<localleader>lc", ":! mix check<CR>", { buffer = true })
