require('plugins')
require('keymappings')
require('settings')
require('lsp_config')

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'    
require "lsp_signature".on_attach()
