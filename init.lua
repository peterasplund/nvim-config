require('plugins')
require('keymappings')
require('settings')
require('lsp_config')

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'    
require "lsp_signature".on_attach()

-- Hacky way to force syntax=php. Should work without it but it doesn't
--[[
local phpBufGroup = vim.api.nvim_create_augroup("php_ft", { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{ pattern = "*.php", command = "set syntax=php", group = phpBufGroup }
)
--]]

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
