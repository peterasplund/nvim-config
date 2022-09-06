local utils = require('utils')

-- Map leader to space
vim.g.mapleader = ' '

utils.map('n', '<F3>', '<cmd>noh<CR>') -- Clear highlights
utils.map('i', 'jj', '<Esc>')           -- jj to escape

utils.map('n', '<Leader>m', '<cmd>:NvimTreeToggle<CR>')
utils.map('n', '<F4>', '<cmd>:NvimTreeFindFile<CR>')

utils.map('n', '<C-p>', '<cmd>:Telescope find_files<CR>') -- Fuzzy find file in project
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

-- LSP specific keybindings
vim.api.nvim_create_autocmd('User', {
  pattern = 'LspAttached',
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
			local opts = { buffer=true, noremap=true, silent=true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

		bufmap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
		bufmap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
		bufmap('n', '<Leader>g', '<Cmd>lua vim.lsp.buf.definition()<CR>')
		bufmap('n', '<Leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>')
		bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
		bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
		bufmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
		bufmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
		bufmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
		bufmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
		bufmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
		bufmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
		bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
		bufmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
		bufmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
		bufmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
		bufmap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
		bufmap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  end
})
