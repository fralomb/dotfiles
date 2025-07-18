-- Use a protected call so we don't error out on first use
local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
	return
end

whichkey.setup {}

