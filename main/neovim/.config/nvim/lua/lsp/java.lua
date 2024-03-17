-- LSP configuration for java

local jdtls_current_workspace = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jdtls_cmd = {}
if os.getenv("JDTLS_ROOT") then
    jdtls_cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        os.getenv("JDTLS_ROOT") ..
        '/plugins/org.eclipse.equinox.launcher_' .. os.getenv("JDTLS_EQUINOX_LAUNCHER") .. '.jar',
        '-configuration', os.getenv("JDTLS_CONFIGURATION"),
        '-data', os.getenv("JDTLS_ROOT") .. '/workspaces/' .. jdtls_current_workspace
    }
end

return {
    cmd = jdtls_cmd,
}
