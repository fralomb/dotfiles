return {
	settings = {
		['helm-ls'] = {
			yamlls = {
				path = "yaml-language-server",
				enabled = true,
				diagnosticsLimit = 50,
				showDiagnosticsDirectly = false,
				config = {
					format = {
						enable = true,
						singleQuote = false,
						bracketSpacing = true,
						proseWrap = "always",
						printWidth = 150
					},
					validate = true,
					completion = true,
					hover = true,
					-- pull in all available schemas from JSON Schema Store (https://www.schemastore.org/json/)
					-- schemaStore = {
					-- 	enable = false
					-- },
					schemas = {
						-- Helm Charts schemas
						["https://json.schemastore.org/chart.json"] = { "**/Chart.yaml" },
						["https://json.schemastore.org/chart-lock.json"] = { "**/Chart.lock" },
						["https://raw.githubusercontent.com/helm-unittest/helm-unittest/v0.3.3/schema/helm-testsuite.json"] = { "**/tests/**.yaml" },
						-- Kubernetes
						kubernetes = "**/templates/*",
					},
				}

			}
		}
	}
}
