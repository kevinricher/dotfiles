vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')

-- contrl+w is an awkward flex, leader->w is better.
vim.keymap.set('n', '<leader>ww', '<C-w>w')
vim.keymap.set('n', '<leader>wo', '<cmd>wincmd o<CR>')
vim.keymap.set('n', '<leader>wp', '<cmd>wincmd p<CR>')
vim.keymap.set('n', '<leader>wh', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<leader>wj', '<cmd>wincmd j<CR>')
vim.keymap.set('n', '<leader>wk', '<cmd>wincmd k<CR>')
vim.keymap.set('n', '<leader>wl', '<cmd>wincmd l<CR>')

vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- What does control C do anyway?
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- Quickfix list
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Diagnostics
vim.keymap.set('n', '<leader>do', "<cmd> lua vim.diagnostic.open_float() <CR>", { desc = "[D]iagnostic [O]pen float" })
vim.keymap.set('n', '<leader>dn', "<cmd> lua vim.diagnostic.goto_next() <CR>", { desc = "[D]iagnostic [O]pen" })
vim.keymap.set('n', '<leader>dp', "<cmd> lua vim.diagnostic.goto_prev() <CR>", { desc = "[D]iagnostic [N]ext" })

-- Soft wrapping for text files
vim.api.nvim_create_augroup('FiletypeSpecificOptions', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'FiletypeSpecificOptions',
  pattern = '*',
  command = 'setlocal nowrap',
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'FiletypeSpecificOptions',
  pattern = { 'markdown', 'text' },
  command = 'setlocal wrap',
})
