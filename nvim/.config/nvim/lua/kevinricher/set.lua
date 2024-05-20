vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Case-insensitive searching unless \C or capital in search.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview live substitutions as you type
vim.opt.inccommand = 'split'

vim.opt.wrap = false

vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.cursorline = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Soft wrapping for text files
vim.api.nvim_create_augroup("FiletypeSpecificOptions", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "FiletypeSpecificOptions",
    pattern = "*",
    command = "setlocal nowrap",
})
vim.api.nvim_create_autocmd("FileType", {
    group = "FiletypeSpecificOptions",
    pattern = {"markdown", "text"},
    command = "setlocal wrap linebreak",
})
