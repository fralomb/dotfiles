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
		config = function()
			-- Set up LSP handlers for hover, signature help, etc.
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})
		end,
	},
	-- Useful status updates for LSP
	{
		"j-hui/fidget.nvim",
		version = "v1.6.1",
		opts = {
			-- notification = {
			-- 	override_vim_notify = true
			-- }
			progress = {
				-- LSP progress configuration
				poll_rate = 0,
				suppress_on_insert = false,
				ignore_done_already = false,
				ignore_empty_message = false,
			},
			notification = {
				-- Disable general notifications, only handle LSP progress
				override_vim_notify = false,
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
		},
	},

	-- github copilot
	-- {  "github/copilot.vim" }

	-- enable code completion from variety of providers
	{
		'milanglacier/minuet-ai.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'hrsh7th/nvim-cmp'
		}
	}
}
