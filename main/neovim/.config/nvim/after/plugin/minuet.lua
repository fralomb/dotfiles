local status_ok, minuet = pcall(require, "minuet")
if not status_ok then
	return
end



minuet.setup {
	virtualtext = {
		auto_trigger_ft = {},
		keymap = {
			-- accept whole completion
			accept = '<A-A>',
			-- accept one line
			accept_line = '<A-a>',
			-- accept n lines (prompts for number)
			-- e.g. "A-z 2 CR" will accept 2 lines
			accept_n_lines = '<A-z>',
			-- Cycle to prev completion item, or manually invoke completion
			prev = '<A-[>',
			-- Cycle to next completion item, or manually invoke completion
			next = '<A-]>',
			dismiss = '<A-e>',
		},
	},
	lsp = {
		enabled_ft = { 'toml', 'lua', 'cpp' },
		-- Enables automatic completion triggering using `vim.lsp.completion.enable`
		enabled_auto_trigger_ft = { 'cpp', 'lua' },
	},
	provider = 'codestral',
	provider_options = {
		codestral = {
			model = 'codestral-latest',
			end_point = 'https://codestral.mistral.ai/v1/fim/completions',
			api_key = 'CODESTRAL_API_KEY',
			stream = true,
			optional = {
				max_tokens = 256,
				stop = { '\n\n' },
			},
		},
	}
}
