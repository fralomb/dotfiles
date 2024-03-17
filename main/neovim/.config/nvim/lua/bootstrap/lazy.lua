local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end
lazy.setup("plugins", {
  root = vim.fn.stdpath("data") .. "/lazy/plugins",
  lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json",
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    -- get a notification when new updates are found
    notify = true
  },
  -- automatically check for config file changes and reload the ui
  change_detection = {
    enabled = true,
    -- get a notification when changes are found
    notify = true,
  },
})
