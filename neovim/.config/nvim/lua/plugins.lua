-- TODO: Describe Packer
return require('packer').startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use {
    'goolord/alpha-nvim',
    config = function ()
      local alpha = require('alpha')
			local dashboard = require('alpha.themes.dashboard')

			-- Set Header
			dashboard.section.header.val = {
        '██████╗  █████╗ ███████╗███████╗██╗     ██╗███╗   ██╗███████╗',
				'██╔══██╗██╔══██╗██╔════╝██╔════╝██║     ██║████╗  ██║██╔════╝',
				'██████╔╝███████║███████╗█████╗  ██║     ██║██╔██╗ ██║█████╗  ',
				'██╔══██╗██╔══██║╚════██║██╔══╝  ██║     ██║██║╚██╗██║██╔══╝  ',
				'██████╔╝██║  ██║███████║███████╗███████╗██║██║ ╚████║███████╗',
				'╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝'
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button('<space><space>', 'find files', ':Telescope find_files<CR>'),
        dashboard.button('?', 'Learn Base', ':e init.lua<CR>')
			}

			alpha.setup(dashboard.opts)
    end
  }

	use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'},
		config = function()
      require('fuzzy')
		end
	}

	use {
    'sainnhe/everforest',
		config = function()
      vim.o.background = 'dark'
			--vim.cmd('colorscheme everforest')
		end
	}

	use {
    'marko-cerovac/material.nvim',
		config = function()
				vim.g.material_style = "oceanic"
				vim.cmd "colorscheme material"
		end
	}
  use {
    'tpope/vim-fugitive',
    config = function()
     vim.keymap.set('n', '<leader>gg', '<CMD>G<CR>') 
     vim.keymap.set('n', '<leader>gl', '<CMD>Gclog<CR>')
     vim.keymap.set('n', '<leader>gh', '<CMD>0Gclog<CR>')
     vim.keymap.set('n', '<leader>gb', '<CMD>Git blame<CR>')
     vim.keymap.set('n', '<leader>gd', '<CMD>Gdiff<CR>')

    end
  }
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'elixir-editors/vim-elixir'
  use {
    'ggandor/leap.nvim',
    config = function()
      require 'leap'.add_default_mappings()
    end

  }
  use {
    'neovim/nvim-lspconfig', 
    config = function()
      require 'language_servers'
    end
  }
  
  use {
    'christoomey/vim-tmux-navigator', 
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = true
    end
  } 
  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require 'nvim-tree'.setup()
      vim.keymap.set('n', '<leader>e', ':NvimTreeFindFile | NvimTreeFocus<cr>')
      vim.keymap.set('n', '<leader>E', ':NvimTreeToggle<cr>')
    end
  }
end)
