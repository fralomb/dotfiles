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
				mode = 1,
				path = 0,
				max_length = vim.o.columns,
				use_mode_colors = true,
				show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
				symbols = {
					modified = '', -- Text to show when the file is modified.
				},

				fmt = function(name, context)
					local buflist = vim.fn.tabpagebuflist(context.tabnr)
					local winnr = vim.fn.tabpagewinnr(context.tabnr)
					local bufnr = buflist[winnr]

					if not bufnr or bufnr == -1 then
						return name
					end

					local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
					local buf_name = name

					if ft == 'oil' then
						-- For oil buffers, use the directory name.
						-- fnamemodify(':t') gets the tail of the path.
						local oil_dir_path = require("oil").get_current_dir(bufnr)
						if oil_dir_path == '' then -- Handle root case like "/"
							oil_dir_path = name
						end
						buf_name = '󰙅 ' .. oil_dir_path
					elseif ft == 'snacks_dashboard' then
						buf_name = '󰨝 Dashboard'
					elseif ft == 'snacks_picker_input' then
						buf_name = ' Picker'
					else
						-- For all other type of files show an icon in case it has been modified
					end

					return buf_name
				end,
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
			{
				require 'minuet.lualine',
				-- the follwing is the default configuration
				-- the name displayed in the lualine. Set to "provider", "model" or "both"
				-- display_name = 'both',
				-- separator between provider and model name for option "both"
				-- provider_model_separator = ':',
				-- whether show display_name when no completion requests are active
				-- display_on_idle = false,
			},
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
