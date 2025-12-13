return {
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			local copilot = require("copilot")
			copilot.setup({
				suggestion = {
					enabled = false, -- Disabled because we use copilot-cmp
				},
				panel = { enabled = false },
				filetypes = {
					gitcommit = true,
					markdown = true,
					yaml = true,
					["*"] = false, -- Default to false, enable specific filetypes above
				},
			})

			-- Keybinding for Copilot command (preserved from old config)
			vim.keymap.set({ "i", "n" }, "<C-k>", "<CMD>:Copilot<CR>")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"f3fora/cmp-spell",
			"tekumara/typos-lsp",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = {
					-- confirm snippets
					["<c-y>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					-- tab to move down list
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					-- shift tab to move backwards
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "copilot" },
					{ name = "luasnip" },
					-- cmp-spell config
					-- {
					-- 	name = "spell",
					-- 	option = {
					-- 		keep_all_entries = false,
					-- 		enable_in_context = function()
					-- 			return true
					-- 		end,
					-- 		preselect_correct_word = true,
					-- 	},
					-- },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			cmp.setup.filetype("lua", {
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
				}),
			})

			cmp.setup.filetype("plsql", {
				sources = cmp.config.sources({
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				}),
			})

			cmp.setup.filetype("sql", {
				sources = cmp.config.sources({
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				}),
			})
		end,
	},
}
