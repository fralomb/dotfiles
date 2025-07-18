-- Use a protected call so we don't error out on first use
local status_ok, neodev = pcall(require, "neodev")
if not status_ok then
    return
end

local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
    return
end

local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

-- Setup neovim lua configuration
neodev.setup()
-- Turn on lsp status information
fidget.setup({
    progress = {
        display = {
            progress_icon = {
                pattern = "bouncing_ball",
                period = 1
            }
        }
    }
})

-- Package manager for install and manage LSP servers, linters, formatters, etc..
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
        vim.keymap.set("n", keys, func, bufopts)
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", function() Snacks.picker.lsp_definitions() end, "[G]oto [D]efinition")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")
    nmap("gI", function() Snacks.picker.lsp_implementations() end, "[G]oto [I]mplementation")

    nmap("K", vim.lsp.buf.hover, "Hover")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folder")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", function() Snacks.picker.lsp_symbols() end, "[D]ocument [S]ymbols")
    nmap("<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")

    nmap("<C-f>", function()
        vim.lsp.buf.format({ async = true })
    end, "[F]ormat current buffer with LSP")
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Enable the following language servers
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config.

local servers = {
    -- jdtls = require("lsp.java").config,
    -- gradle_ls = require("lsp.gradlels").config,
    groovyls = require("lsp.groovyls"),
    html = require("lsp.jsonls"),
    cssls = require("lsp.jsonls"),
    jsonls = require("lsp.jsonls"),
    dockerls = require("lsp.dockerls"),
    pylsp = require("lsp.pylsp"),
    bashls = require("lsp.bashls"),
    lua_ls = require("lsp.lua_ls"),
    efm = require("lsp.efm"),
    yamlls = require("lsp.yamlls"),
    helm_ls = require("lsp.helmls"),
    tflint = require("lsp.tflint"),
    terraformls = require("lsp.terraformls"),
    gopls = require("lsp.gopls"),
    htmx = require("lsp.htmxls"),
    omnisharp = require("lsp.omnisharp"),
    tailwindcss = require("lsp.tailwindls"),
    angularls = require("lsp.angular")
}

-- Bridges mason with lspconfig plugin
mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

-- Using the new vim.lsp.config and vim.lsp.enable APIs for server configuration
for server_name, config in pairs(servers) do
    -- Add capabilities and on_attach to each server's config
    config.capabilities = capabilities
    config.on_attach = on_attach
    
    -- Configure the server using the new API
    vim.lsp.config(server_name, config)
    -- Enable all the servers at once
    vim.lsp.enable(server_name)
end


-- Enable built-in LSP completion
vim.lsp.completion.enable()
