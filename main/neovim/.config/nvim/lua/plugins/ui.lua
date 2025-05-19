return {
  -- Rosé Pine colorscheme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   vim.cmd("colorscheme rose-pine")
    -- end,
  },

  { "nvim-tree/nvim-web-devicons",         lazy = true },

  -- Set status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },

--   {
--   "folke/snacks.nvim",
--   priority = 1000,
--   lazy = false,
--   ---@type snacks.Config
--   opts = {
--     -- your configuration comes here
--     -- or leave it empty to use the default settings
--     -- refer to the configuration section below
--     bigfile = { enabled = true },
--     dashboard = { enabled = true },
--     explorer = { enabled = true },
--     indent = { enabled = true },
--     input = { enabled = true },
--     picker = { enabled = true },
--     notifier = { enabled = true },
--     quickfile = { enabled = true },
--     scope = { enabled = true },
--     scroll = { enabled = true },
--     statuscolumn = { enabled = true },
--     words = { enabled = true },
--   },
-- },

  -- -- File explorer
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  -- preview markdown files
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && npm install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- },
  -- managing restoring sessions in neovim
  -- { "rmagatti/auto-session" },
  -- adds indentation guides
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  ---- Evaluate Hex colors
  --use({ "chrisbra/Colorizer" })


  ---- Transparent bg
  --use({ "xiyaowong/nvim-transparent" })


  ---- Guess current buffer indentation
  { "nmac427/guess-indent.nvim" },

  -- -- Tailwindcss integration
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   enabled = true
  -- }

}
