-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  } 

  use({ 'rose-pine/neovim', as = 'rose-pine' })

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		  ts_update()
	  end,
  }
  use('nvim-treesitter/playground')

  use('nvim-lua/plenary.nvim')
  use {
	  "ThePrimeagen/harpoon",
	  branch = "harpoon2",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use('preservim/nerdtree')

  use{
	  'neoclide/coc.nvim',
	  branch = 'release',
  }
  use{
	  'yaegassy/coc-volar',
	  run = 'npm install --frozen-lock',
  }

  use{
	  'yaegassy/coc-volar-tools',
	  run = 'npm install --frozen-lock',
  }
  -- Plugins here.
  use 'lervag/vimtex'

end)
