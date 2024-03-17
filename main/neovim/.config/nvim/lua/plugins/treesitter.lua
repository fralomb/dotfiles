return {
  -- Treesitter: highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ':TSUpdate',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    dependencies = {
      "nvim-treesitter/playground",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
  }
}
