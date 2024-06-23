return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",
    },
  },
  -- Useful status updates for LSP
  {
    "j-hui/fidget.nvim",
    version = "v1.1.0",
    opts = {
      notification = {
        override_vim_notify = true
      }
    }
  },

  -- for formatters and linters not included in lspconfig
  {
    'creativenull/efmls-configs-nvim',
    version = 'v1.*',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  -- helm charts syntax
  {
    'towolf/vim-helm',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  -- jinja syntax highlighting
  {
    'Glench/Vim-Jinja2-Syntax'
  },
  -- {
  --   'mhartington/formatter.nvim'
  -- },
  {'tzachar/cmp-ai', dependencies = 'nvim-lua/plenary.nvim'},

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      -- Snippet Engine & its associated nvim-cmp source
      { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      -- ai completion endpoint
      'tzachar/cmp-ai'
    },
  },

  -- github copilot
  -- {  "github/copilot.vim" }
}
