return require('packer').startup(function ()
  use 'wbthomason/packer.nvim'
  use 'nanotech/jellybeans.vim'
  use 'ChristianChiarulli/nvcode-color-schemes.vim'
  use 'tjdevries/nlua.nvim'
  use {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init({ mode = 'symbol' })
    end,
  }

-- Disable for now. This causes a deprecation error
--[[
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
--]]

  use {
    'kyazdani42/nvim-tree.lua', -- File explorer sidebar
    config = function()
      require("nvim-tree").setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      config = function()
        local treesitter_configs = require("nvim-treesitter.configs")

        treesitter_configs.setup({
          highlight = {
            enable = true,
          },
          indent = {
            disable = { "php" },
            enable = true,
          },
          rainbow = {
            enable = true,
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          },
        })
      end
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
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
  --use 'windwp/nvim-autopairs'
  
  
	use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
  use "hrsh7th/vim-vsnip"
  use "ray-x/lsp_signature.nvim"
  use "StanAngeloff/php.vim"

  --use 'chemzqm/vim-jsx-improve'
  -- use 'maxmellon/vim-jsx-pretty'

  use 'editorconfig/editorconfig-vim'

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufRead",
    commit = "25d4b182ece5b03cd4b2d8c196f3c38e0df58801",
  }

end)