-- Use a protected call so we don't error out on first use
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	return
end
local status_ok, trouble = pcall(require, 'trouble.providers.telescope')
if not status_ok then
	return
end
-- Use a protected call so we don't error out on first use
local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
	return
end

whichkey.setup {}

telescope.setup {
	defaults = {
		mappings = {
			n = {
				["<c-t>"] = trouble.open_with_trouble,
				['<c-k>'] = require('telescope.actions').delete_buffer
			},
			i = {
				["<c-t>"] = trouble.open_with_trouble,
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
				['<c-k>'] = require('telescope.actions').delete_buffer
			}
		},
		prompt_prefix = '🔍 ',
		file_ignore_patterns = {
			'node_modules',
			'%.git/',
			'site%-packages',
			'%.terraform'
		},
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
			'--hidden'
		},
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				local is_image = function(image_filepath)
					local image_extensions = { 'png', 'jpg' } -- Supported image formats
					local split_path = vim.split(image_filepath:lower(), '.', { plain = true })
					local extension = split_path[#split_path]
					return vim.tbl_contains(image_extensions, extension)
				end
				if is_image(filepath) then
					local term = vim.api.nvim_open_term(bufnr, {})
					local function send_output(_, data, _)
						for _, d in ipairs(data) do
							vim.api.nvim_chan_send(term, d .. '\r\n')
						end
					end
					vim.fn.jobstart(
						{
							'viu', filepath -- Terminal image viewer command
						},
						{ on_stdout = send_output, stdout_buffered = true, pty = true })
				else
					require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
						"Binary cannot be previewed")
				end
			end
		},
	},
	pickers = {
		find_files = {
			find_command = { 'rg', '--files', '--hidden', '-u' }
		}
	},
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>ss', builtin.grep_string, { desc = '[S]earch [S]tring under cursor' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<C-g>f', builtin.git_files, { desc = '[G]it [F]iles - respects .gitignore' })
vim.keymap.set('n', '<C-g>c', builtin.git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<C-g>b', builtin.git_branches, { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<C-g>s', builtin.git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<C-g>h', builtin.git_stash, { desc = '[G]it stas[H]' })
-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ")});
-- end)
