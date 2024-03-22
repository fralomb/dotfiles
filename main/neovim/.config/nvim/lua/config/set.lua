-- Set leader key, it must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader=' '
vim.g.maplocalleader = ' '

-- disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Disable mode information from default status line
vim.opt.showmode = false

-- Set highlight on search
vim.opt.hlsearch = true
-- Search while typing if the pattern matches
vim.opt.incsearch = true

-- Make line numbers default
vim.opt.number = true
-- Show the line number relative to the cursor line
vim.opt.relativenumber = true

-- Save undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("NVIM_MAINDIR") .. "/undodir"
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- No wrapping text
vim.opt.wrap = false

-- Enable break indent
vim.opt.breakindent = true

-- Decrease update time
vim.opt.updatetime = 250
vim.o.timeoutlen = 300

-- Draw an extra column, useful for linting, git, etc..
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = "80"

-- Minimal number of screen lines from the cursor
vim.opt.scrolloff = 4

-- File indentation by default
vim.opt.shiftwidth=4
vim.opt.tabstop=4

-- Enables 24-bit RGB color 
vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Show spaces, tabs and eol
vim.opt.list = true
vim.opt.listchars:append "tab:» "
-- vim.opt.listchars:append "tab:  "
-- vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "trail:·"
-- vim.opt.listchars:append "eol:¶"

-- Highlight cursor line and column
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
