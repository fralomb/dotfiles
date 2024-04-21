-- Keep Visual Mode after indenting with > or <
vim.keymap.set("v", "<", [[<gv]], { desc = 'Indenting line to the left' })
vim.keymap.set("v", ">", [[>gv]], { desc = 'Indenting line to the right' })

-- Move line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line Down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line Up' })

-- move up and down while mantaining the cursor centered
vim.keymap.set('n', 'j', "v:count == 0 ? 'gjzz' : 'jzz'", { expr = true, silent = true, desc = 'Navigate Down (also in wrap mode)'})
vim.keymap.set('n', 'k', "v:count == 0 ? 'gkzz' : 'kzz'", { expr = true, silent = true, desc = 'Navigate Up (also in wrap mode)' })
-- vim.keymap.set('n', 'j', [[jzz]])
-- vim.keymap.set('n', 'k', [[kzz]])
vim.keymap.set('n', '<C-u>', [[<C-u>zz]], { desc = 'Scroll up mantaining page centered' })
vim.keymap.set('n', '<C-d>', [[<C-d>zz]], { desc = 'Scroll down mantaining page centered' })

-- copy/paste/delete from/to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["*y]], { desc = 'Yank below into clipboard (register *)' })
vim.keymap.set({"n", "v"}, "<leader>Y", [["*Y]], { desc = 'Yank above into clipboard (register *)' })
vim.keymap.set({"n", "v"}, "<leader>p", [["*p]], { desc = 'Paste below from clipboard (register *)' })
vim.keymap.set({"n", "v"}, "<leader>P", [["*P]], { desc = 'Paste above from clipboard (register *)' })
vim.keymap.set({"n", "v"}, "<leader>x", [["*x]], { desc = 'Delete next char and copy into clipboard (register *)' })
vim.keymap.set({"n", "v"}, "<leader>X", [["*X]], { desc = 'Delete prev char and copy into clipboard (register *)' })
vim.keymap.set({"n", "v"}, "<leader>d", [["*d]], { desc = 'Delete text that {motion} moves over (register *)' })
vim.keymap.set({"n", "v"}, "<leader>D", [["*D]], { desc = 'Delete the characters under the cursor until the end of the line and [count]-1 more lines (register *)' })

-- Escape key in terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-N>]], { desc = 'Escape key in terminal mode' })

-- Search within selection
vim.keymap.set('x', '/', '<Esc>/\\%V', { desc = 'search within selection' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Copilot
vim.keymap.set('i', '<M-l>', '<Plug>(copilot-accept-word)', { desc = 'Accept one word of the current suggestion' })
vim.keymap.set('i', '<M-L>', '<Plug>(copilot-accept-line)', { desc = 'Accept entire line of the current suggestion' })
