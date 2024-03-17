-- LSP configuration for bash and zsh

return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "zsh" },
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
			includeAllWorkspaceSymbols = true
		}
	}
}
