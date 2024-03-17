-- LSP configuration for golang
local golang_group = vim.api.nvim_create_augroup('golang_autoimports', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = golang_group,
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		-- buf_request_sync defaults to a 1000ms timeout. Depending on your
		-- machine and codebase, you may want longer. Add an additional
		-- argument after params if you find that you have to write the file
		-- twice for changes to be saved.
		-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end
})

return {
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			staticcheck = true,
			gofumpt = true,
			usePlaceholders = true,
			-- directoryFilters = { "-", "+**/templates", "-**/templates/k8s-manifests" },
			templateExtensions = { "hcl", "tpl", "tmpl" },
			semanticTokens = true,
			analyses = {
				unreachable = true, -- Disable the unreachable analyzer.
				unusedparams = true -- Enable the unusedparams analyzer.
			},
			hoverKind = "Structured", -- Experimental setting that returns a structured hover format
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			importShortcut = "Both", -- specifies whether import statements should link to documentation or go to definitions
			symbolMatcher = "FastFuzzy", -- sets the algorithm that is used when finding workspace symbols
		},
	},
}
