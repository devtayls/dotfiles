return {
	"elixir-editors/vim-elixir",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"nvim-cmp",
			"which-key.nvim",
		},
		config = function()
			local lsp_config = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local null_ls = require("null-ls")
			local configs = require("lspconfig.configs")

			local formatting_augrop = vim.api.nvim_create_augroup("LSPFORMATTING", {})

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
						-- Format buffer
						["f"] = { vim.lsp.buf.format, "format" },
						["r"] = { vim.lsp.buf.references, "references" },
						["s"] = { vim.lsp.buf.signature_help, "sig help" },
					},
				}, { prefix = "<leader>" })

				-- Enter to go to definition
				vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, options)

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

			-- Add more LSP servers here
			if not configs.lexical then
				configs.lexical = {
					default_config = {
						filetypes = { "elixir", "eelixir", "heex" },
						cmd = {
							vim.loop.os_homedir() .. "/code/lexical/_build/dev/package/lexical/bin/start_lexical.sh",
						},
						root_dir = function(fname)
							return lsp_config.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
						end,
					},
				}
			end

			lsp_config.lexical.setup({ on_attach = attach })

			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			-- lsp_config.vale_ls.setup({
			-- 	on_attach = attach,
			-- 	capabilities = capabilities,
			-- })

			lsp_config.terraformls.setup({
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
							checkThirdParty = false,
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
				settings = {
					format = true,
				},
				capabilities = capabilities,
			})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
				},
				on_attach = attach,
			})

			return { on_atach = attach }
		end,
	},
}
