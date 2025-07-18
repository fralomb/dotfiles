local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
	return
end

local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
	return
end

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local compare = require('cmp.config.compare')

local kind_icons = {
	Number = '󰎠',
	Array = '',
	Variable = '',
	-- and other icons
	-- LLM Provider icons
	claude = '󰋦',
	openai = '󱢆',
	codestral = '󱎥',
	gemini = '',
	Groq = '',
	Openrouter = '󱂇',
	Ollama = '󰳆',
	['Llama.cpp'] = '󰳆',
	Deepseek = '',
	-- FALLBACK
	fallback = '',
}

local source_icons = {
	minuet = '󱗻',
	nvim_lsp = '',
	lsp = '',
	buffer = '',
	luasnip = '',
	snippets = '',
	path = '',
	git = '',
	tags = '',
	-- FALLBACK
	fallback = '󰜚',
}

-- Setup completion engine nvim-cmp
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<A-y>"] = require('minuet').make_cmp_map(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sorting = {
		priority_weight = 2,
		comparators = {
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = 'minuet' },
		{ name = "codecompanion" },
	}),
	performance = {
		-- It is recommended to increase the timeout duration due to
		-- the typically slower response speed of LLMs compared to
		-- other completion sources. This is not needed when you only
		-- need manual completion.
		fetching_timeout = 2000,
	},

	-- Enable completion integration with built-in LSP completion
	completion = {
		completeopt = "menu,menuone,noinsert"
	},

	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			-- This concatenates the icons with the name of the item kind
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or kind_icons.fallback, vim_item.kind)
			-- Source
			vim_item.menu = source_icons[entry.source.name] or source_icons.fallback
			return vim_item
		end,
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
