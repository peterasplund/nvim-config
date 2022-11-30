return require('packer').startup(function ()
  use 'wbthomason/packer.nvim'
  use 'nanotech/jellybeans.vim'
	use 'folke/tokyonight.nvim'
  use 'ChristianChiarulli/nvcode-color-schemes.vim'
  use 'tjdevries/nlua.nvim'

  use {
    'kyazdani42/nvim-tree.lua', -- File explorer sidebar
    config = function()
      require("nvim-tree").setup()
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
			vim.cmd("TSUpdate bash")
			vim.cmd("TSUpdate c")
			vim.cmd("TSUpdate dockerfile")
			vim.cmd("TSUpdate dot")
			vim.cmd("TSUpdate graphql")
			vim.cmd("TSUpdate haskell")
			vim.cmd("TSUpdate html")
			vim.cmd("TSUpdate java")
			vim.cmd("TSUpdate javascript")
			vim.cmd("TSUpdate typescript")
			vim.cmd("TSUpdate json")
			vim.cmd("TSUpdate lua")
			vim.cmd("TSUpdate php")
			vim.cmd("TSUpdate python")
			vim.cmd("TSUpdate ruby")
			vim.cmd("TSUpdate rust")
			vim.cmd("TSUpdate toml")
			vim.cmd("TSUpdate vim")
			vim.cmd("TSUpdate yaml")
			vim.cmd("TSUpdate gdscript")
		end,
		config = function()
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
				autotag = { enable = true },
				indent = {
					--disable = { "php" },
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				},
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
		end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
		config = function()
			require("telescope").setup({
				pickers  = {
					find_files = {
						hidden = true,
						-- Hide git
						file_ignore_patterns = {".git"}
					}
				}
			})
		end
  }

  use {
		'romgrk/barbar.nvim',
		requires = {
			-- https://github.com/romgrk/barbar.nvim/issues/98
			{'kyazdani42/nvim-web-devicons' }
		},
	}
  use { 'neovim/nvim-lspconfig' }
  use 'norcalli/nvim-colorizer.lua'
  
	use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"
  use "ray-x/lsp_signature.nvim"

  use 'editorconfig/editorconfig-vim'

	-- Debuggger	
	use 'mfussenegger/nvim-dap'

	use 'mustache/vim-mustache-handlebars'

	-- Status bar	
	use 'feline-nvim/feline.nvim'

	use 'endaaman/vim-case-master'

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufRead",
  }
end)

