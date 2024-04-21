-- Use a protected call so we don't error out on first use
local status_ok, tailwind = pcall(require, 'tailwind-tools')
if not status_ok then
	return
end

tailwind.setup({
	document_color = {
		enabled = true, -- can be toggled by commands
		kind = "foreground", -- "inline" | "foreground" | "background"
		inline_symbol = "󰝤 ", -- only used in inline mode
		debounce = 200, -- in milliseconds, only applied in insert mode
	},
	conceal = {
		enabled = false, -- can be toggled by commands
		symbol = "󱏿", -- only a single character is allowed
		highlight = { -- extmark highlight options, see :h 'highlight'
			fg = "#38BDF8",
		},
	},
	custom_filetypes = {} -- see the extension section to learn how it works
})
