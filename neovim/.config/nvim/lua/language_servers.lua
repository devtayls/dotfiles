local lsp_config = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local null_ls = require("null-ls")

local attach = function(client, buffer_number)
	local options = {
		buffer = buffer_number,
	}

	local wk = require("which-key")

	wk.register({
		l = {
			name = "language",
			-- Open Hover window of Symbols
			["h"] = { vim.lsp.buf.hover, "hover def" },
			-- Open Quicklist of Symbols
			["O"] = { vim.lsp.buf.document_symbol, "quicklist sym" },
			-- Open Telscope of Symbols
			["o"] = { ":Telescope lsp_document_symbols<CR>", "telescop sym" },
			["f"] = { vim.lsp.buf.format, "format" },
			["r"] = { vim.lsp.buf.references, "references" },
			["s"] = { vim.lsp.buf.signature_help, "sig help" },
		},
	}, { prefix = "<leader>" })

	-- Enter to go to definition
	vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, options)

	-- show hover window of definition
	-- vim.keymap.set("n", "<LEADER>lh", vim.lsp.buf.hover, options)
	-- vim.keymap.set("n", "<LEADER>lO", vim.lsp.buf.document_symbol, options)
	-- -- show Telescop window listing lsp object
	-- vim.keymap.set("n", "<LEADER>lo", ":Telescope lsp_document_symbols<CR>", options)

	local formatting_augrop = vim.api.nvim_create_augroup("LSPFORMATTING", {})

	if client.supports_method("textDocument/formatting") then
		print(client.name)
		vim.api.nvim_clear_autocmds({ group = formatting_augrop, buffer = buffer_number })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = formatting_augrop,
			buffer = buffer_number,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end
end

lsp_config.elixirls.setup({
	cmd = { "elixir-ls" },
	on_attach = attach,
	capabilities = capabilities,
	settings = {
		elixirLS = {
			dialyzerEnabled = true,
		},
	},
})

lsp_config.vale_ls.setup({
	on_attach = attach,
	capabilities = capabilities,
})

lsp_config.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

lsp_config.eslint.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
	},
	on_attach = attach,
})

return { on_atach = attach }
