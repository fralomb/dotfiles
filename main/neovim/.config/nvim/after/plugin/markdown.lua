local status_ok, table = pcall(require, "markdown-table-mode")
if not status_ok then
    return
end

local status_ok, markview = pcall(require, "markview")
if not status_ok then
    return
end

table.setup({
  filetype = {
    '*.md',
  },
  options = {
    insert = true, -- when typing "|"
    insert_leave = true, -- when leaving insert
    pad_separator_line = false, -- add space in separator line
    alig_style = 'default', -- default, left, center, right
  },
})

markview.setup({
	preview = {
        icon_provider = "devicons",
    }
});
