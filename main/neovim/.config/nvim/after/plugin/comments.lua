-- Use a protected call so we don't error out on first use
local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
  return
end
local status_ok, ft = pcall(require, 'Comment.ft')
if not status_ok then
  return
end

comment.setup()
-- set same commentstring for terraform and hcl
ft({'hcl'}, ft.get('terraform'))
ft({'hurl'}, '# %s')
