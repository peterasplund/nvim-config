local utils = require('utils')

utils.map('n', '<F3>', '<cmd>noh<CR>') -- Clear highlights
utils.map('i', 'jj', '<Esc>')           -- jj to escape

utils.map('n', '<Leader>m', '<cmd>:NvimTreeToggle<CR>')
utils.map('n', '<F4>', '<cmd>:NvimTreeFindFile<CR>')

utils.map('n', '<C-p>', '<cmd>:Telescope git_files<CR>')
utils.map('n', '<F2>', '<cmd>:Telescope live_grep<CR>')

-- easier cursor navigation between split windows using CTRL and h,j,k, or l
utils.map('n', '<C-h>', '<C-w>h')
utils.map('n', '<C-j>', '<C-w>j')
utils.map('n', '<C-k>', '<C-w>k')
utils.map('n', '<C-l>', '<C-w>l')

-- Move between buffers easier
utils.map('n', '<Leader>j', ':bnext<CR>')
utils.map('n', '<Leader>k', ':previous<CR>')

utils.map('n', '<F1>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
