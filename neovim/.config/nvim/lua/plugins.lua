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

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require 'gitsigns'

      function next_hunk()
        -- Move to next hunk
        gitsigns.next_hunk()
        -- center cursor
        vim.cmd('normal zz')
      end

      function prev_hunk()
        -- Move to prev hunk
        gitsigns.prev_hunk()
        -- center cursor
        vim.cmd('normal zz')
      end


      gitsigns.setup {
        signs = {
          add          = {text = '│'},
          change       = {text = '│'},
          delete       = {text = '│'},
          topdelete    = {text = '│'},
          changedelete = {text = '│'},
        },
        on_attach = function(bufnr)
          local map = vim.keymap.set
          local opts = {silent = true}

          map('n', ']g', next_hunk, opts)
          map('n', '[g', prev_hunk, opts)
          map('n', '<leader>g+', gitsigns.stage_hunk, opts)
          map('n', '<leader>g-', gitsigns.undo_stage_hunk, opts)
          map('n', '<leader>g=', gitsigns.reset_hunk, opts)
          map('n', '<leader>gp', gitsigns.preview_hunk, opts)
        end
      }
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter", 
    config = function ()
      require('treesitter')
    end, 
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground' 
    }
  } 

  use {
    "hrsh7th/nvim-cmp", 
    requires = {
       'hrsh7th/cmp-nvim-lsp',
       'hrsh7th/cmp-nvim-lua',
       'hrsh7th/cmp-buffer',
       'hrsh7th/cmp-path',
       'hrsh7th/cmp-cmdline',
       'L3MON4D3/LuaSnip',
       'saadparwaiz1/cmp_luasnip',
    }, 
    config = function()
      require('autocompletion')
    end 
  } 

end)
