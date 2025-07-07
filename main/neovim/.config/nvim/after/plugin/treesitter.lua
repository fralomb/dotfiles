-- local install_dir = os.getenv("NVIM_MAINDIR") .. [[/parsers/]]

-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	-- Use a protected call so we don't error out on first use
	local status_ok, treesitter = pcall(require, "nvim-treesitter")
	if not status_ok then
		return
	end
	local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end
	treesitter_configs.setup({
		-- A list of parser names, or "all"
		ensure_installed = { "arduino", "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "csv", "diff", "dockerfile", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "gowork", "groovy", "hcl", "hjson", "html", "htmldjango", "http", "hurl", "ini", "java", "javascript", "jq", "jsdoc", "json", "json5", "jsonc", "latex", "lua", "luadoc", "luap", "make", "markdown", "markdown_inline", "typst", "python", "regex", "requirements", "scss", "sql", "ssh_config", "styled", "toml", "typescript", "vim", "vimdoc", "xml", "yaml" },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		-- List of parsers to ignore installing (for "all")
		ignore_install = {},

		---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
		-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

		highlight = {
			-- `false` will disable the whole extension
			enable = true,

			-- list of language that will be disabled (the name of the parser goes here)
			-- disable = { "c", "rust" },
			-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
			disable = function(lang, buf)
				local max_filesize = 1024 * 1024 -- 1 MB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
			-- disable = { "python" },
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn", -- set to `false` to disable one of the mappings
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>A'] = '@parameter.inner',
				},
			},
		},

		-- parser_install_dir = install_dir
	})

	-- -- add parser for hurl
	-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
	--
	-- -- https://github.com/nvim-treesitter/nvim-treesitter/tree/master#adding-parsers
	-- parser_config.hurl = {
	--   install_info = {
	--     url = "~/git/github.com/kjuulh/tree-sitter-hurl",
	--     files = { "src/parser.c" },
	--     branch = "main",
	--     generate_requires_npm = false,
	--     requires_generate_from_grammar = false,
	--   },
	--   filetype = "hurl",
	-- }
	--
	--
	-- -- https://neovim.io/doc/user/lua.html#vim.filetype.add()
	-- -- Search for vim.filetype.add
	-- vim.filetype.add({
	--   extension = {
	--     hurl = "hurl"
	--   }
	-- })
	-- set a specific parser for a filetype
	-- vim.treesitter.language.register('terraform', 'tfpl')
end, 0)
