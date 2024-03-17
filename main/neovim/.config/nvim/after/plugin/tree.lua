-- Use a protected call so we don't error out on first use
local status_ok, tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end
local status_ok, api = pcall(require, "nvim-tree.api")
if not status_ok then
  return
end

-- disable netrw and use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Open file explorer
vim.keymap.set("n", "<C-t>", function()
  api.tree.toggle({ focus = false })
end)

tree.setup({
  disable_netrw = true,
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
  },
  diagnostics = {
    enable = true,
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  modified = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
  },
  view = {
    adaptive_size = true,
    width = 40,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = true,
        modified = true,
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
})

-- open nvim tree on startup
-- local function open_nvim_tree(data)
--   -- find the file if it exists
--   api.tree.find_file({ buf = data.file, open = true, focus = false })
-- end
--
-- local nvimtree_group = vim.api.nvim_create_augroup("nvimtree_filetype_detect", { clear = true })
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   group = nvimtree_group,
--   callback = open_nvim_tree,
-- })

