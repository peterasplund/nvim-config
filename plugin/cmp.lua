-- https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt

local cmp = require('cmp')
local utils = require('utils')
local lspkind = require('lspkind')

-- vim.cmd [[set shortmess+=c]]
utils.opt('o', 'completeopt', 'menu,menuone,noselect')

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    },
    {
      { name = 'buffer', keyword_length = 5, max_item_count = 5 },
    }
  ),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        -- @TODO: maybe add stuff here
        return vim_item
      end
    })
  }
}
