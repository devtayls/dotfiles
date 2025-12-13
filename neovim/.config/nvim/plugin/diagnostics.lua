vim.diagnostic.config({
	underline = {
		severity = { min = vim.diagnostic.severity.WARN }, -- Underline Error and Warn only
	},
	virtual_text = {
		prefix = " ",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
		},
	},
})

-- Show diagnostic modal
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic" })