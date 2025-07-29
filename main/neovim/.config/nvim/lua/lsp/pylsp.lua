return {
	settings = {
		pylsp = {
			plugins = {
				-- refactoring library for completions, autoimports, renaming
				rope_autoimport = {
					enabled = true,
					completions = { enabled = true },
					code_actions = { enabled = true },
					memory = true,
					-- Add these for better performance:
					imports = { "django", "requests", "numpy", "pandas" }, -- common libraries
				},
				rope_completion = { enabled = true, eager = true, },
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
				yapf = { enabled = true },
				pylsp_isort = { enabled = true },
				-- Jedi settings (important for completions)
				jedi_completion = {
					enabled = true,
					include_params = true,
					include_class_objects = true,
					fuzzy = true,
				},
				jedi_hover = { enabled = true },
				jedi_references = { enabled = true },
				jedi_signature_help = { enabled = true },
				jedi_symbols = {
					enabled = true,
					all_scopes = true,
				},
			}
		}
	}
}
