return {
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
		event = { "BufReadPre", "BufNewFile" },
		build = ":MasonUpdate",
		config = function()
			local mason = require("mason")

			local package_list = {
				-- LSPs
				"elixir-ls",
			}

			mason.setup({})

			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(package_list) do
					local ok, p = pcall(mr.get_package, tool)
					if ok and not p:is_installed() then
						p:install()
					end
				end
			end

			-- registry may not be loaded on first run; refresh is async
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = true,
		},
	},
}
