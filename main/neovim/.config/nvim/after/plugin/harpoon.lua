-- Use a protected call so we don't error out on first use
local status_ok, harpoon = pcall(require, 'harpoon')
if not status_ok then
	return
end


harpoon.setup({
	global_settings = {
		-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
		save_on_toggle = false,

	-- saves the harpoon file upon every change. disabling is unrecommended.
		save_on_change = true,

		-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
		enter_on_sendcmd = true,

		-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
		tmux_autoclose_windows = true,

		-- filetypes that you want to prevent from adding to the harpoon list menu.
		excluded_filetypes = { "harpoon" }
	},
	projects = {
		-- ["$HOME/personal/wedding"] = {
		-- 	term = {
		-- 		cmds = {
		-- 			"httpwatcher -p 8080"
		-- 		}
		-- 	}
		-- }
	}
})
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<C-h>a", mark.add_file, { desc = 'Add file to harpoon' })
vim.keymap.set("n", "<C-h>n", ui.nav_next, { desc = 'Navigate next file in harpoon stack' })
vim.keymap.set("n", "<C-h>p", ui.nav_prev, { desc = 'Navigate previous file in harpoon stack' })
vim.keymap.set("n", "<C-h>m", ui.toggle_quick_menu, { desc = 'Toggle harpoon menu' })

vim.keymap.set("n", "<leader>tu", function() term.gotoTerminal(1) end, { desc = 'Go to terminal 1' })
vim.keymap.set("n", "<leader>te", function() term.gotoTerminal(2) end, { desc = 'Go to terminal 2' })
vim.keymap.set("n", "<leader>au", function() term.sendCommand(1, "genotp") end, { desc = 'Generate OTP in terminal 1' })
vim.keymap.set("n", "<leader>ae", function() term.sendCommand(2, "genotp") end, { desc = 'Generate OTP in terminal 2' })
-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)


-- Rename current tmux window with name of project folder
local utils = require("harpoon.utils")
local rename_tmuxw_group = vim.api.nvim_create_augroup('rename_tmux_window', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		local dir_path = utils.split_string(vim.loop.cwd(), "/")
		local window_name = dir_path[#dir_path]
		local _, _, _ = utils.get_os_command_output({
			"tmux",
			"rename-window",
			window_name,
		}, vim.loop.cwd())

	end,
	group = rename_tmuxw_group,
	pattern = '*',
})


