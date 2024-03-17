return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.4",
    branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-tree/nvim-web-devicons"
    },
  },
  -- native telescope sorter to significantly improve sorting performance
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  -- Harpoon
  { "theprimeagen/harpoon" },

  -- Comment both lines and blocks
  { "numToStr/Comment.nvim" },

  -- which-key
  { "folke/which-key.nvim",                     event = "VeryLazy" },

  -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- File explorer
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- Git status for oil
  -- {
  --   "refractalize/oil-git-status.nvim",
  --
  --   dependencies = {
  --     "stevearc/oil.nvim",
  --   },
  --
  --   config = true,
  -- }
}
