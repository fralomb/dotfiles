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

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Set status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
	},

	-- markdown tables
	{
		'Kicamon/markdown-table-mode.nvim',
		lazy = true
	},

	-- AI code companion
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
			-- "nvim-telescope/telescope.nvim",
			"folke/snacks.nvim",
			"j-hui/fidget.nvim",
			"OXY2DEV/markview.nvim",
		},
		init = function()
			require("plugins.codecompanion.fidget-spinner"):init()
		end,
	},
	-- preview markdown files
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		opts = function()
			local function conceal_tag(icon, hl_group)
				return {
					on_node = { hl_group = hl_group },
					on_closing_tag = { conceal = '' },
					on_opening_tag = {
						conceal = '',
						virt_text_pos = 'inline',
						virt_text = { { icon .. ' ', hl_group } },
					},
				}
			end

			return {
				html = {
					container_elements = {
						['^buf$']         = conceal_tag('', 'CodeCompanionChatVariable'),
						['^file$']        = conceal_tag('', 'CodeCompanionChatVariable'),
						['^help$']        = conceal_tag('󰘥', 'CodeCompanionChatVariable'),
						['^image$']       = conceal_tag('', 'CodeCompanionChatVariable'),
						['^symbols$']     = conceal_tag('', 'CodeCompanionChatVariable'),
						['^url$']         = conceal_tag('󰖟', 'CodeCompanionChatVariable'),
						['^var$']         = conceal_tag('', 'CodeCompanionChatVariable'),
						['^tool$']        = conceal_tag('', 'CodeCompanionChatTool'),
						['^user_prompt$'] = conceal_tag('', 'CodeCompanionChatTool'),
						['^group$']       = conceal_tag('', 'CodeCompanionChatToolGroup'),
					},
				},
				preview = {
					filetypes = { "markdown", "codecompanion" },
					ignore_buftypes = {},
				},
			}
		end,
	},


	-- -- File explorer
	-- {
	--   "nvim-tree/nvim-tree.lua",
	--   dependencies = {
	--     "nvim-tree/nvim-web-devicons",
	--   },
	-- },

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

	---- Evaluate Hex colors
	--use({ "chrisbra/Colorizer" })


	---- Transparent bg
	--use({ "xiyaowong/nvim-transparent" })


	-- ---- Guess current buffer indentation
	-- { "nmac427/guess-indent.nvim" },

	-- -- Tailwindcss integration
	-- {
	--   "luckasRanarison/tailwind-tools.nvim",
	--   dependencies = { "nvim-treesitter/nvim-treesitter" },
	--   enabled = true
	-- }

}
