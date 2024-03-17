-- LSP configuration for yaml

return {
	filetypes = { "yaml", "yml" },
	settings = {
		redhat = {
			telemetry = {
				enabled = false
			}
		},
		editor = {
			tabSize = 2
		},
		yaml = {
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
				-- Github workflows
				["https://json.schemastore.org/github-workflow.json"] = { "/.github/workflows/*" },
				-- Azure pipelines
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = { "**/azure-pipelines.yml", "**/azure-pipelines*.yml" },
				-- Kubernetes kustomize
				["https://json.schemastore.org/kustomization.json"] = { "**/kustomization/*" },
				-- Kubernetes
				["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = {
					"**/infrastructure.yaml",
					"**/kubernetes/*.yaml",
					"**/k8s-manifests/*.yaml",
					"**/infrastructure.yml",
					"**/kubernetes/*.yml",
					"**/k8s-manifests/*.yml",
				},
			},
		},
	},
}
