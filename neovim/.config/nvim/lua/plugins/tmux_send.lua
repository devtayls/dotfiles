--- Send text/paths from Neovim into the tmux pane running Claude Code CLI.
---
--- Auto-detects the target pane by scanning sibling panes for a `claude`
--- process (dkarter-style "nearest sibling wins"), so no numeric prefix is
--- needed. Uses `tmux paste-buffer -p` (bracket-paste) to keep large pastes
--- from tripping up the CLI's line editor.
---
--- Complements claudecode.nvim: use `<leader>as` for MCP-level structured
--- sends (buffer/selection with semantic context); use `<leader>ap` here
--- when you just want to shove raw text into the CLI as if you typed it.

---@type LazySpec

local function list_panes()
	local fmt = "#{pane_id}\t#{session_name}\t#{window_index}\t#{pane_index}\t#{pane_current_command}"
	local out = vim.fn.systemlist({ "tmux", "list-panes", "-a", "-F", fmt })
	local panes = {}
	for _, line in ipairs(out) do
		local id, session, window, index, cmd = line:match("^(%S+)\t(%S+)\t(%S+)\t(%S+)\t(%S+)$")
		if id then
			table.insert(panes, {
				id = id,
				session = session,
				window = tonumber(window),
				index = tonumber(index),
				cmd = cmd,
			})
		end
	end
	return panes
end

local function current_pane()
	if vim.env.TMUX_PANE and vim.env.TMUX_PANE ~= "" then
		return vim.env.TMUX_PANE
	end
	return vim.fn.systemlist({ "tmux", "display-message", "-p", "#{pane_id}" })[1]
end

---@param panes table[] list of panes from list_panes()
---@param current_id string current pane id (e.g. "%5")
---@return string|nil target pane_id
local function pick_claude_pane(panes, current_id)
	local self = vim.iter(panes):find(function(p)
		return p.id == current_id
	end)
	if not self then
		return nil
	end
	local best, best_score
	for _, p in ipairs(panes) do
		if p.id ~= current_id and p.cmd:match("claude") and p.session == self.session then
			local score = (p.window == self.window and 0 or 1000) + math.abs(p.index - self.index)
			if not best_score or score < best_score then
				best, best_score = p, score
			end
		end
	end
	return best and best.id or nil
end

local function send_text(text, submit)
	if not text or text == "" then
		return
	end
	local target = pick_claude_pane(list_panes(), current_pane())
	if not target then
		vim.notify("tmux_send: no Claude pane found", vim.log.levels.WARN)
		return
	end
	local buffer_name = "nvim-claude-" .. os.time() .. "-" .. math.random(1000)
	vim.fn.system({ "tmux", "set-buffer", "-b", buffer_name, text })
	vim.fn.system({ "tmux", "paste-buffer", "-b", buffer_name, "-t", target, "-p" })
	vim.fn.system({ "tmux", "delete-buffer", "-b", buffer_name })
	if submit then
		vim.fn.system({ "tmux", "send-keys", "-t", target, "Enter" })
	end
end

local function send_line()
	send_text(vim.api.nvim_get_current_line(), true)
end

local function send_selection()
	local mode = vim.fn.mode()
	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
	send_text(table.concat(lines, "\n"), false)
end

local function send_buffer()
	send_text(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"), false)
end

local function send_diagnostic()
	local lnum = vim.fn.line(".") - 1
	local diags = vim.diagnostic.get(0, { lnum = lnum })
	if #diags == 0 then
		vim.notify("tmux_send: no diagnostic on this line", vim.log.levels.WARN)
		return
	end
	local file = vim.fn.expand("%:.")
	local parts = { "Explain this error and suggest a fix:", "" }
	for _, d in ipairs(diags) do
		local sev = vim.diagnostic.severity[d.severity] or "?"
		table.insert(parts, string.format("%s:%d [%s] %s", file, d.lnum + 1, sev, d.message))
	end
	send_text(table.concat(parts, "\n"), true)
end

local function focus_claude_pane()
	local target = pick_claude_pane(list_panes(), current_pane())
	if not target then
		vim.notify("tmux_send: no Claude pane found", vim.log.levels.WARN)
		return
	end
	vim.fn.system({ "tmux", "select-pane", "-t", target })
end

local function send_tree_path()
	local ok, api = pcall(require, "nvim-tree.api")
	if not ok then
		return
	end
	local node = api.tree.get_node_under_cursor()
	if node and node.absolute_path then
		send_text(node.absolute_path, false)
	end
end

return {
	"kiyoon/tmux-send.nvim",
	keys = {
		{ "<leader>ap", send_line, desc = "Paste line to Claude pane" },
		{ "<leader>ap", send_selection, mode = "x", desc = "Paste selection to Claude pane" },
		{ "<leader>aP", send_buffer, desc = "Paste buffer to Claude pane" },
		{ "<leader>ae", send_diagnostic, desc = "Ask Claude about diagnostic" },
		{ "<leader>af", focus_claude_pane, desc = "Focus Claude pane" },
		{ "<leader>ap", send_tree_path, desc = "Paste file path to Claude pane", ft = "NvimTree" },
	},
}
