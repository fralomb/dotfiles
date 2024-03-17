-- Use a protected call so we don't error out on first use
local status_ok, indent = pcall(require, "ibl")
if not status_ok then
       return
end
local status_ok, guess = pcall(require, "guess-indent")
if not status_ok then
       return
end

guess.setup({})

local highlight = {
       "CursorColumn",
       "Whitespace",
       "Whitespace",
       "NonText",
       "Function",
       "Label",
}
indent.setup({
       debounce = 100,
       indent = { highlight = highlight, char = " ", smart_indent_cap = true, priority = 2 },
       whitespace = {
              highlight = highlight,
              remove_blankline_trail = true,
       },
       scope = {
              enabled = true,
              show_start = true,
              show_end = false,
              injected_languages = false,
              highlight = { "Function", "Label" },
              priority = 500,
              include = {
                     node_type = { lua = { "return_statement", "table_constructor" } },
              },
       },
})
