return {
	-- Removing this breaks Treesitter syntax highlighting. Maybe because of a filetype detection issue? IDK
	"elixir-editors/vim-elixir",
	{
		"elixir-tools/elixir-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local elixir = require("elixir")
			local elixirls = require("elixir.elixirls")

			elixir.setup({
				nextls = { enable = false },
				elixirls = {
					enable = true,
					settings = elixirls.settings({
						dialyzerEnabled = false,
						enableTestLenses = false,
					}),
				},
				projectionist = {
					-- projectionist is enabled elsewhere
					enable = false,
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-cmp",
			"which-key.nvim",
			"tekumara/typos-lsp",
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
			local lsp_config = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local configs = require("lspconfig.configs")

			local attach = function(client, buffer_number)
				local options = {
					buffer = buffer_number,
				}

				-- Enter to go to definition
				vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, options)
			end

			-- Add more LSP servers here
			-- lsp_config.elixirls.setup({
			-- 	on_attach = attach,
			-- 	cmd = {
			-- 		vim.loop.os_homedir() .. "/code/elixir-ls-v0.27.1/language_server.sh",
			-- 	},
			-- 	settings = {
			-- 		elixirLS = {
			-- 			-- Show dialyzer diagnostics
			-- 			dialyzerEnabled = true,
			-- 			-- Set this to true for projects with large dependency trees
			-- 			dialyzerWarnOnlyForDeps = false,
			-- 			-- Enable formatting through elixir-ls (uses mix format)
			-- 			enableMixFormatter = true,
			-- 			-- Fetch deps automatically when compiling
			-- 			fetchDeps = true,
			-- 			-- Show errors and warnings from Mix compiler
			-- 			mixEnv = "dev",
			-- 			-- Enable automatic compilation on file save
			-- 			autoBuild = true,
			-- 		},
			-- 	},
			-- })

			-- Terraform
			lsp_config.terraformls.setup({
				on_attach = attach,
				capabilities = capabilities,
			})

			-- Lua
			-- lsp_config docs have a much more involved config. If something is weird, maybe grab that config?
			lsp_config.lua_ls.setup({
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


			-- Biome
			lsp_config.biome.setup({
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

			-- typos lsp
			lsp_config.typos_lsp.setup({
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

			return { on_attach = attach }
		end,
	},
}
