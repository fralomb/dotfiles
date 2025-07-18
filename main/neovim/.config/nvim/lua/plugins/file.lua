return {
	-- Harpoon
	{ "theprimeagen/harpoon" },

	-- Comment both lines and blocks
	{ "numToStr/Comment.nvim" },

	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/snacks.nvim"
		},
	},

	-- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/snacks.nvim"
		},
		specs = {
			"folke/snacks.nvim",
			opts = function(_, opts)
				return vim.tbl_deep_extend("force", opts or {}, {
					picker = {
						actions = require("trouble.sources.snacks").actions,
						win = {
							input = {
								keys = {
									["<c-t>"] = {
										"trouble_open",
										mode = { "n", "i" },
									},
								},
							},
						},
					},
				})
			end,
		},
	},

	-- File explorer
	{
		'stevearc/oil.nvim',
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
