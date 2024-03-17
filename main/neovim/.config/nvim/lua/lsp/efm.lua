-- local stylua = require("efmls-configs.formatters.stylua")
-- local luacheck = require("efmls-configs.linters.luacheck")
local beautysh = require("efmls-configs.formatters.beautysh")
-- local shellcheck = require("efmls-configs.linters.shellcheck")

local languages = {
	-- lua = { stylua, luacheck },
	sh = { beautysh },
	zsh = { beautysh }
}

return {
	filetypes = vim.tbl_keys(languages),
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
}
