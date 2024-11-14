return {
	"elixir-editors/vim-elixir",
	-- Neoformat handles formatting for languages on bufwritepre. Most languages are included by default
	{
		"sbdchd/neoformat",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- Set up Neoformat to format on save
			vim.api.nvim_create_augroup("fmt", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = "fmt",
				pattern = "*",
				command = "undojoin | Neoformat",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-cmp",
			"which-key.nvim",
		},
		config = function()
			local lsp_config = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local configs = require("lspconfig.configs")

			local attach = function(client, buffer_number)
				local options = {
					buffer = buffer_number,
				}

				local wk = require("which-key")

				wk.add({
					{ "<leader>l", group = "+language" },
					-- Open Hover window of Symbols
					{ "<leader>lh", vim.lsp.buf.hover, { desc = "hover def" } },

					-- Open Quicklist of Symbols
					{ "<leader>lO", vim.lsp.buf.document_symbol, { desc = "quicklist sym" } },
					-- Open Telscope of Symbols
					{ "<leader>lo", ":Telescope lsp_document_symbols<CR>", { desc = "telescop sym" } },

					-- Format buffer
					{ "<leader>lf", vim.lsp.buf.format, { desc = "format" } },
					{ "<leader>lr", vim.lsp.buf.references, { desc = "references" } },
					{ "<leader>ls", vim.lsp.buf.signature_help, { desc = "sig help" } },
				})

				-- Enter to go to definition
				vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, options)

				-- local formatting_augrop = vim.api.nvim_create_augroup("LSPFORMATTING", {})
				-- Format on save with lspconfig
				-- if client.supports_method("textDocument/formatting") then
				-- 	print(client.name)
				-- 	vim.api.nvim_clear_autocmds({ group = formatting_augrop, buffer = buffer_number })
				-- 	vim.api.nvim_create_autocmd("BufWritePre", {
				-- 		group = formatting_augrop,
				-- 		buffer = buffer_number,
				-- 		callback = function()
				-- 			vim.lsp.buf.format()
				-- 		end,
				-- 	})
				-- end
			end

			-- Add more LSP servers here
			-- Lexical for Elixir
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

			-- Terraform
			lsp_config.terraformls.setup({
				on_attach = attach,
				capabilities = capabilities,
			})

			-- Lua
			-- lsp_config docs have a much more involved config. If something is weird, maybe grab that config?
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

			-- Eslint
			lsp_config.eslint.setup({
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			return { on_atach = attach }
		end,
	},
}
