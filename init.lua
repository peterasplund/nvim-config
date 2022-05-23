-- @TODO: find out a way to automatically run vim.diagnostic.hide() on php buffers

require('plugins')
require('lsp_lua')
require('keymappings')
require('settings')

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'    

local function attach_lsp_keybinds(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	-- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Leader>g', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

--require'lspconfig'.pyright.setup{}
--
lspconfig.efm.setup{
	filetypes = {"lua", "python", "javascriptreact", "javascript", "sh", "html", "css", "yaml", "markdown"},
  on_attach = attach_lsp_keybinds,
}
lspconfig.flow.setup{
  on_attach = attach_lsp_keybinds,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

lspconfig.psalm.setup{
  on_attach = attach_lsp_keybinds,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_publish_diagnostics = { virtual_text = false },
	cmd = {"x", "psalm", "--language-server"},
	flags = { debounce_text_changes = 150 },
}

require "lsp_signature".on_attach()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'scss', 'css'};
      snippetSupport = true;
      root_dir = function(_)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

lspconfig.emmet_ls.setup{
  capabilities = capabilities;
  on_attach = attach_lsp_keybinds;
}

--[[
if not lspconfig.xo_custom then
  configs.xo_custom = {
    default_config = {
      cmd = {'xo', '--stdio'};
      filetypes = {'js', 'jsx'};
      root_dir = function(_)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

lspconfig.xo_custom.setup{}
--]]


-- Hacky way to force syntax=php. Should work without it but it doesn't
local phpBufGroup = vim.api.nvim_create_augroup("php_ft", { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{ pattern = "*.php", command = "set syntax=php", group = phpBufGroup }
)

-- xdebug setup
--[[
local dap = require('dap')
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/peter/.config/nvim/lib/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003
  }
}
--]]
