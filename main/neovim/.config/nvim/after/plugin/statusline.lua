-- Use a protected call so we don't error out on first use
local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
	return
end
-- local status_ok, auto_session = pcall(require, 'auto-session.lib')
-- if not status_ok then
-- 	return
-- end
local status_ok, lazy = pcall(require, 'lazy.status')
if not status_ok then
	return
end
local status_ok, custom_rosepine = pcall(require, 'lualine.themes.rose-pine')
if not status_ok then
	return
end
-- local function current_session()
-- 	return '[' .. auto_session.current_session_name() .. ']'
-- end


-- Change the background of lualine_c section for normal mode
local p = require("rose-pine.palette")
local config = require("rose-pine.config")

local bg_base = p.base
if config.options.styles.transparency then
	bg_base = "NONE"
end

custom_rosepine = {
	normal = {
		a = { bg = p.pine, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.pine },
		c = { bg = bg_base, fg = p.text },
	},
	insert = {
		a = { bg = p.foam, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.foam },
		c = { bg = bg_base, fg = p.text },
	},
	visual = {
		a = { bg = p.iris, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.iris },
		c = { bg = bg_base, fg = p.text },
	},
	replace = {
		a = { bg = p.gold, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.gold },
		c = { bg = bg_base, fg = p.text },
	},
	command = {
		a = { bg = p.love, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.love },
		c = { bg = bg_base, fg = p.text },
	},
	inactive = {
		a = { bg = bg_base, fg = p.muted, gui = "bold" },
		b = { bg = bg_base, fg = p.muted },
		c = { bg = bg_base, fg = p.muted },
	},
}

lualine.setup {
	options = {
		theme         = custom_rosepine,
		icons_enabled = true,
	},
	tabline = {
		lualine_a = {
			{
				'tabs',
				mode = 0,
				-- show only when multiple tabs are enabled
				cond = function()
					local count = 0
					for _, _ in ipairs(vim.api.nvim_list_tabpages()) do
						count = count + 1
					end
					return (count > 1)
				end
			}
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {
			{
				'buffers',
				cond = function()
					return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
				end
			}
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = {
			-- { current_session },
			{
				'filename',
				path = 1, -- show file relative path
			}
		},
		lualine_x = {
			'encoding',
			'fileformat',
			'filetype',
			{
				lazy.updates,
				cond = lazy.has_updates,
				color = { fg = "#ff9e64" },
			},
		},
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	extensions = {
		'nvim-tree',
	}
}
