local status_ok, session = pcall(require, 'auto-session')
if not status_ok then
	return
end
local status_ok, tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end
local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
	return
end

local function change_nvim_tree_dir()
	tree.change_dir(vim.fn.getcwd())
end

session.setup({
	log_level = "error",
	auto_session_enable_last_session = false,
	auto_session_enabled = true,
	auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
	cwd_change_handling = {
		restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
		pre_cwd_changed_hook = nil,  -- already the default, no need to specify like this, only here as an example
		post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
			lualine.refresh()        -- refresh lualine so the new session name is displayed in the status bar
		end,
	},
	post_restore_cmds = { change_nvim_tree_dir, "NvimTreeOpen" },
	pre_save_cmds = { "NvimTreeClose" },

	auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
})

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
	noremap = true,
	desc = 'Search for neovim sessions opened'
})
