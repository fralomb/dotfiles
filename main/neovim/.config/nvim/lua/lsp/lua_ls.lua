-- LSP configuration for lua

return {
    settings = {
        Lua = {
            format = {
                enable = true,
                -- Put format options here
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                }
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            completion = {
                enable = true,
                autoRequire = true,
                callSnippet = "Both",
                keywordSnippet = "Both"
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                enable = true,
                globals = { 'vim', 'require' }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- Automatic detection and adaptation of third-party libraries
                checkThirdParty = false
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    }
}
