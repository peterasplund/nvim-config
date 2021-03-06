local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  highlight = { enable = true },
  textobjects = { enable = true },
  indent = { enable = false },
  autotag = { enable = true },
  ensure_installed = {
    'bash',
    'css',
    'html',
    'javascript',
    'php',
    'python',
    'query',
    'rust',
    'toml',
    'yaml',
  },
})