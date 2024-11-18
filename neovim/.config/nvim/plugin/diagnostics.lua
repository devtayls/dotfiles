vim.diagnostic.config({
	underline = true,
	virtual_text = {
		prefix = " ",
	},
	signs = true,
})

-- Show diagnostic modal
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "show diagnostic in hover buf" })

local signs = { Error = "󰈸 ", Warn = "󰒡 ", Hint = " " }

-- Consigure signs
for type, icon in pairs(signs) do
	local highlight = "DiagnosticSign" .. type
	vim.fn.sign_define(highlight, { text = icon, texthl = highlight })
end
