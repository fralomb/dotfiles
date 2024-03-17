
-- LSP configuration for terraform
return {
	config = {
		filetypes = { "terraform", "terraform-vars" },
		validation = {
			enableEnhancedValidation = true
		}
	}
}
