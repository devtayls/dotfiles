vim.diagnostic.config({
	underline = {
		severity = { min = vim.diagnostic.severity.WARN }, -- Underline Error and Warn only
	},
	virtual_text = {
		prefix = " ",
	},
	signs = true,
})

-- Show diagnostic modal
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic" })

local signs = { Error = "󰈸 ", Warn = "󰒡 ", Hint = " " }

-- Configure signs
for type, icon in pairs(signs) do
	local highlight = "DiagnosticSign" .. type
	vim.fn.sign_define(highlight, { text = icon, texthl = highlight })
end
