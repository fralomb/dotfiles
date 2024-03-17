local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
	return
end
local status_ok, futil = pcall(require, "formatter.util")
if not status_ok then
	return
end

formatter.setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua
		},
		sh = {
			-- require("formatter.filetypes.sh").shfmt
			require("formatter.filetypes.zsh").beautysh
		},
		zsh = {
			require("formatter.filetypes.zsh").beautysh
		}

	}
})
