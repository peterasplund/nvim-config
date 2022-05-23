local utils = require('utils')

-- Map leader to space
vim.g.mapleader = ' '

utils.map('n', '<F3>', '<cmd>noh<CR>') -- Clear highlights
utils.map('i', 'jj', '<Esc>')           -- jj to escape

utils.map('n', '<Leader>m', '<cmd>:NvimTreeToggle<CR>')
utils.map('n', '<F4>', '<cmd>:NvimTreeFindFile<CR>')

utils.map('n', '<C-p>', '<cmd>:Telescope git_files<CR>') -- Fuzzy find file in project
utils.map("", "<Leader>p", "<cmd>lua require('telescope.builtin').find_files({no_ignore = true})<CR>", { noremap = true, silent = true }) -- Fuzzy find file in project, ignoring ignores
utils.map('n', '<F2>', '<cmd>:Telescope live_grep<CR>') -- Grep all files in project

-- easier cursor navigation between split windows using CTRL and h,j,k, or l
utils.map('n', '<C-h>', '<C-w>h')
utils.map('n', '<C-j>', '<C-w>j')
utils.map('n', '<C-k>', '<C-w>k')
utils.map('n', '<C-l>', '<C-w>l')

-- Move between buffers easier
utils.map('n', '<Leader>j', ':bnext<CR>')
utils.map('n', '<Leader>k', ':previous<CR>')

utils.map('n', '<F1>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')

-- Debugger
utils.map('n', 'db', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>')
utils.map('n', 'dc', '<cmd>lua require\'dap\'.continue()<CR>')
utils.map('n', 'dsi', '<cmd>lua require\'dap\'.step_into()<CR>')
utils.map('n', 'dso', '<cmd>lua require\'dap\'.step_over()<CR>')
utils.map('n', 'dss', '<cmd>lua require\'dap\'.repl.open()<CR>')
