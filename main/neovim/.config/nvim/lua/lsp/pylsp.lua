return {
	settings = {
		pylsp = {
			plugins = {
				-- refactoring library for completions, autoimports, renaming
				rope_autoimport = {
					enabled = true,
					completions = { enabled = true },
					code_actions = { enabled = true },
				},
				rope_completion = { enabled = true },
				-- linter for error detection
				pyflakes = { enabled = true },
				-- linter for complexity checking, anything that goes beyond 10 is too complex
				mccabe = {
					enabled = true,
					threshold = 10
				},
				-- linter for style checking
				pycodestyle = {
					enabled = true,
					ignore = { 'W391' },
					maxLineLength = 150
				},
				-- code formatting
				autopep8 = { enabled = false },
				yapf = { enabled = true }
			}
		}
	}
}
