local status_ok, Snacks = pcall(require, "snacks")
if not status_ok then
	return
end

Snacks.config.bigfile = { enabled = true }
Snacks.config.explorer = { enabled = false }
Snacks.config.indent = {
	enabled = true,
	animate = {
		enabled = true,
		style = "out",
		easing = "inOutCubic", -- "linear",
		duration = {
			step = 10,         -- ms per step
			total = 250,       -- maximum duration
		},
	},
}
Snacks.config.input = { enabled = true }
Snacks.config.notifier = {
	enabled = true,
	timeout = 2500,
	style = "compact"
}
Snacks.config.win = {
	enabled = true,
}
Snacks.config.picker = { enabled = false }
Snacks.config.quickfile = { enabled = true }
Snacks.config.scope = { enabled = true }
Snacks.config.scroll = { enabled = true }
Snacks.config.statuscolumn = { enabled = true }
Snacks.config.words = { enabled = true }
Snacks.config.styles = {
	notification = {
		border = "rounded",
		zindex = 100,
		ft = "markdown",
		wo = {
			winblend = 5,
			wrap = false,
			conceallevel = 2,
			colorcolumn = "",
		},
		bo = { filetype = "snacks_notif" },
	},
	notification_history = {
		border = "rounded",
		zindex = 100,
		width = 0.6,
		height = 0.6,
		minimal = false,
		title = " Notification History ",
		title_pos = "center",
		ft = "markdown",
		bo = { filetype = "snacks_notif_history", modifiable = false },
		wo = { winhighlight = "Normal:SnacksNotifierHistory" },
		keys = { q = "close" },
	},
	input = {
		backdrop = false,
		position = "float",
		border = "rounded",
		title_pos = "center",
		height = 1,
		width = 60,
		relative = "editor",
		noautocmd = true,
		row = 2,
		-- relative = "cursor",
		-- row = -3,
		-- col = 0,
		wo = {
			winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
			cursorline = false,
		},
		bo = {
			filetype = "snacks_input",
			buftype = "prompt",
		},
		--- buffer local variables
		b = {
			completion = false, -- disable blink completions in input
		},
		keys = {
			n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
			i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
			i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
			i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
			i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
			i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
			i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
			q = "cancel",
		},
	}
}
Snacks.config.dashboard = {
	enabled = true,
	sections = {
		{ section = "header" },
		-- {
		-- 	pane = 2,
		-- 	section = "terminal",
		-- 	cmd = "colorscript -e square",
		-- 	height = 5,
		-- 	padding = 1,
		-- },
		{ section = "keys", gap = 1, padding = 1 },
		{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
		{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
		{
			pane = 2,
			icon = " ",
			title = "Git Status",
			section = "terminal",
			enabled = function()
				return Snacks.git.get_root() ~= nil
			end,
			cmd = "git status --short --branch --renames",
			height = 5,
			padding = 1,
			ttl = 5 * 60,
			indent = 3,
		},
		{ section = "startup" },
	},
}


