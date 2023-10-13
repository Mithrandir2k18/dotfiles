vim.opt.guicursor = "" -- set block-cursor

-- set cursor to block always
vim.opt.guicursor = "n-v-c-i:block"
-- set relative number line
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.textwidth = 88

-- set tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- configure search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- configure netrw
vim.g.netrw_banner = true
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

-- hide cmdline by default and toggle if needed
vim.o.cmdheight = 0
