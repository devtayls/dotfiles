return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"which-key.nvim",
		},
		lazy = false,
		keys = {
			-- Open Hover window of Symbols
			{ "<leader>lh", vim.lsp.buf.hover, desc = "hover def" },
			-- Open Quicklist of Symbols
			{ "<leader>lO", vim.lsp.buf.document_symbol, desc = "quicklist sym" },
			-- Open Telscope of Symbols
			{ "<leader>lo", ":Telescope lsp_document_symbols<CR>", desc = "telescop sym" },

			-- Format buffer
			{ "<leader>lr", vim.lsp.buf.references, desc = "references" },
			{ "<leader>ls", vim.lsp.buf.signature_help, desc = "sig help" },
		},
		config = function()
			-- Get capabilities from cmp-nvim-lsp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local attach = function(client, buffer_number)
				local options = {
					buffer = buffer_number,
				}

				-- Enable semantic highlighting (richer than treesitter) when the server supports it
				if client.server_capabilities.semanticTokensProvider then
					vim.lsp.semantic_tokens.enable(true, { bufnr = buffer_number })
				end

				-- Enter to go to definition
				vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, options)
				-- Code actions (buffer-local, only available when LSP is attached)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, options)
			end

			-- Terraform
			vim.lsp.config("terraformls", {
				on_attach = attach,
				capabilities = capabilities,
			})
			vim.lsp.enable("terraformls")

			-- Elixir — elixirls handles hover/format/completion, dexter owns definition/references
			vim.lsp.config("elixirls", {
				on_attach = function(client, bufnr)
					client.server_capabilities.definitionProvider = false
					client.server_capabilities.referencesProvider = false
					attach(client, bufnr)
				end,
				capabilities = capabilities,
				settings = {
					elixirLS = {
						dialyzerEnabled = false,
						enableTestLenses = false,
						fetchDeps = false,
						signatureAfterComplete = true,
					},
				},
			})

			-- Lua
			-- lsp_config docs have a much more involved config. If something is weird, maybe grab that config?
			vim.lsp.config("lua_ls", {
				on_attach = attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						format = {
							enable = true,
						},
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
			vim.lsp.enable("lua_ls")

			-- Biome
			vim.lsp.config("biome", {
				on_attach = attach,
				capabilities = capabilities,
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"json",
					"jsonc",
				},
			})
			vim.lsp.enable("biome")

			-- typos lsp
			vim.lsp.config("typos_lsp", {
				on_attach = attach,
				capabilities = capabilities,
				-- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
				cmd_env = { RUST_LOG = "error" },
				init_options = {
					-- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
					-- Defaults to error.
					diagnosticSeverity = "Warning",
				},
			})
			vim.lsp.enable("typos_lsp")

			-- YAML
			vim.lsp.config("yamlls", {
				on_attach = attach,
				capabilities = capabilities,
				settings = {
					yaml = {
						schemaStore = {
							-- Enable built-in schemaStore support
							enable = true,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
					},
				},
			})
			vim.lsp.enable("yamlls")

			-- Bash
			vim.lsp.config("bashls", {
				on_attach = attach,
				capabilities = capabilities,
			})
			vim.lsp.enable("bashls")

			-- Docker
			vim.lsp.config("dockerls", {
				on_attach = attach,
				capabilities = capabilities,
			})
			vim.lsp.enable("dockerls")

			-- Go
			vim.lsp.config("gopls", {
				on_attach = attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
			vim.lsp.enable("gopls")

			-- Dexter - Fast Elixir LSP (works alongside ElixirLS)
			vim.lsp.config("dexter", {
				on_attach = attach,
				capabilities = capabilities,
				cmd = { vim.fn.expand("~/.local/share/mise/shims/dexter"), "lsp" },
				root_markers = { ".dexter.db", ".git", "mix.exs" },
				filetypes = { "elixir", "eelixir", "heex" },
				init_options = {
					followDelegates = true, -- jump through defdelegate to target function
				},
			})
			vim.lsp.enable("dexter")

			return { on_attach = attach }
		end,
	},
}
