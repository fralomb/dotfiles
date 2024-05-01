-- for work, all jenkinsfile templates does not have extension
local jenkins_group = vim.api.nvim_create_augroup('jenkins_filetype_detect', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  command = 'setfiletype groovy',
  group = jenkins_group,
  pattern = {'*pipeline_templates/*','*.jenkinsfile','*Jenkinsfile'},
})

-- for work, all helm charts should be evaluated with golsp
local gotmpl_group = vim.api.nvim_create_augroup('tpl_filetype_detect', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  command = 'setfiletype gotmpl',
  group = gotmpl_group,
  pattern = { '**/templates/**/*.tpl', '**/templates/**/*.tmpl' },
})

-- Highlight text yanked
local highlight_group = vim.api.nvim_create_augroup('yank_highlighted_text', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
  group = highlight_group,
  pattern = '*',
})


-- set filetype for splitted tmux configuration
local tmux_ft_group = vim.api.nvim_create_augroup('tmux_filetype_detect', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  command = 'setfiletype tmux',
  group = tmux_ft_group,
  pattern = '*.tmux',
})


local brew_ft_group = vim.api.nvim_create_augroup('brew_filetype_detect', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  command = 'setfiletype ruby',
  group = brew_ft_group,
  pattern = {'*Brewfile'},
})

-- Disables Github Copilot for specific dir
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   pattern = '*',
--   command = "Copilot disable"
-- })
--
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   pattern = vim.fn.expand('$HOME/workspace') .. '/*',
--   command = "Copilot enable"
-- })
