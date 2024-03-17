-- Use a protected call so we don't error out on first use
local status_ok, trouble = pcall(require, 'trouble')
if not status_ok then
	return
end

trouble.setup{}


local nmap = function(keys, func, desc)
	if desc then
		desc = 'Trouble: ' .. desc
	end

	local bufopts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set('n', keys, func, bufopts)
end

nmap('<leader>xx', "<cmd>TroubleToggle<cr>", 'Toggle Trouble menu')
nmap('<leader>xw', "<cmd>TroubleToggle workspace_diagnostics<cr>", 'Toggle [w]orkspace diagnostics')
nmap('<leader>xd', "<cmd>TroubleToggle document_diagnostics<cr>", 'Toggle [d]ocument diagnostics')
nmap('<leader>xl', "<cmd>TroubleToggle loclist<cr>", 'Toggle [l]ocation list')
nmap('<leader>xq', "<cmd>TroubleToggle quickfix<cr>", 'Toggle [q]uickfix list')
nmap('gR', "<cmd>TroubleToggle lsp_references<cr>", 'Toggle lsp [r]eferences')

nmap('<leader>xn', function() trouble.next({skip_groups = true, jump = true}) end, 'Jump to the [n]ext item, skipping the groups')
nmap('<leader>xp', function() trouble.previous({skip_groups = true, jump = true}) end, 'Jump to the [p]previous item, skipping the groups')
nmap('<leader>xf', function() trouble.first({skip_groups = true, jump = true}) end, 'Jump to the [f]irst item, skipping the groups')
nmap('<leader>xl', function() trouble.last({skip_groups = true, jump = true}) end, 'Jump to the [l]ast item, skipping the groups')
