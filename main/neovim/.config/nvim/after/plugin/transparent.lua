-- Use a protected call so we don't error out on first use
local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
  return
end

transparent.setup({
  -- extra_groups = {
  --   -- example of akinsho/nvim-bufferline.lua
  --   "BufferLineTabClose",
  --   "BufferlineBufferSelected",
  --   "BufferLineFill",
  --   "BufferLineBackground",
  --   "BufferLineSeparator",
  --   "BufferLineIndicatorSelected",
  --   "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
  --   "NvimTreeNormal", -- NvimTree
  --   "SignColumn"
  -- },
  -- exclude_groups = {}, -- table: groups you don't want to clear
})
