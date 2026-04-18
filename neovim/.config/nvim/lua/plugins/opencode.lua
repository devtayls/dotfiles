--- integrate with opencode
---@type LazySpec
return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		{ "folke/snacks.nvim", opts = { input = {}, picker = {} } },
	},
	---@module 'opencode'
	---@type opencode.Opts
	opts = {
		provider = { enabled = "snacks" },
		auto_reload = true,
	},
	config = function(_, opts)
		vim.g.opencode_opts = opts
		vim.o.autoread = true
	end,
	keys = {
		-- Main actions
		{
			"<leader>ot",
			function()
				require("opencode").ask("@this: ", { submit = true })
			end,
			mode = { "n", "x" },
			desc = "Ask opencode",
		},
		{
			"<leader>oa",
			function()
				require("opencode").prompt("@this")
			end,
			mode = { "n", "x" },
			desc = "Add to opencode",
		},
		{
			"<leader>os",
			function()
				require("opencode").select()
			end,
			mode = { "n", "x" },
			desc = "Select opencode action",
		},
		{
			"<leader>oc",
			function()
				require("opencode").toggle()
			end,
			desc = "Toggle opencode",
		},

		-- Quick prompts
		{
			"<leader>oe",
			function()
				require("opencode").prompt(require("opencode.config").opts.prompts.explain.prompt)
			end,
			mode = { "n", "x" },
			desc = "OpenCode: Explain",
		},
		{
			"<leader>or",
			function()
				require("opencode").prompt(require("opencode.config").opts.prompts.review.prompt)
			end,
			mode = { "n", "x" },
			desc = "OpenCode: Review",
		},
		{
			"<leader>of",
			function()
				require("opencode").prompt(require("opencode.config").opts.prompts.fix.prompt)
			end,
			desc = "OpenCode: Fix diagnostics",
		},

		-- Session management
		{
			"<leader>on",
			function()
				require("opencode").command("session_new")
			end,
			desc = "OpenCode: New session",
		},
		{
			"<leader>oi",
			function()
				require("opencode").command("session_interrupt")
			end,
			desc = "OpenCode: Interrupt",
		},
	},
}
