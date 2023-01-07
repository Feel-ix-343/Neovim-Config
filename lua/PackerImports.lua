local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- Package manager

	use { 'nvim-treesitter/nvim-treesitter' }

	-- Themes
	use 'folke/tokyonight.nvim'
	use {
		'catppuccin/nvim',
		as = "catppuccin",
	}
	use 'mhartington/oceanic-next'
	use 'frenzyexists/aquarium-vim'
	use 'pgdouyon/vim-yin-yang'
	use 'sainnhe/everforest'
	use 'luisiacc/gruvbox-baby'
  use {'shaunsingh/oxocarbon.nvim', run = './install.sh'}
  use {'michaeldyrynda/carbon'}
  use ({ 'projekt0n/github-nvim-theme' })
  use {"bluz71/vim-nightfly-colors"}
  use 'kvrohit/mellow.nvim'
	------------------------------------------------------

  use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
  use {
	  'nvim-lualine/lualine.nvim', -- Fancier statusline
	  config = function ()
		  require('lualine').setup {
			  options = {
				  theme = 'catppuccin',
				  icons_enabled = true,
				  component_separators = { left = '', right = ''},
				  section_separators = { left = '', right = ''},
			  },
        sections = { lualine_c = { "require'lsp-status'.status()" } }
		  }
	  end
  }

  -- LSP STUFF
	use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use { 'hrsh7th/nvim-cmp', -- Autocompletion plugin
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  -- use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use({
	  "glepnir/lspsaga.nvim",
	  branch = "main",
  })
  use { 'nvim-lua/lsp-status.nvim' }
  use 'folke/neodev.nvim'
  use { "williamboman/mason.nvim" }
  use 'williamboman/mason-lspconfig.nvim'
  use {
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
  }
  use 'simrat39/rust-tools.nvim'
  -- LSP STUFF END ---------------------------------------------------------------

  -- use {
  --   'romgrk/barbar.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons'}
  -- }

  use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- use({
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()

  --     vim.diagnostic.config({
  --       virtual_text = false
  --     })
  --   end,
  -- })

  use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})

  use { 'windwp/nvim-autopairs' }
  use 'windwp/nvim-ts-autotag'

  use { "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
	  require("todo-comments").setup {
		  search = {
			  command = "rg",
			  args = {
				  "--color=never",
				  "--no-heading",
				  "--with-filename",
				  "--line-number",
				  "--column",
				  "--glob=!node_modules",
			  },
			  pattern = [[\b(KEYWORDS):]],
		  },
	  }
  end
}

use 'tpope/vim-obsession'

  use {
    'karb94/neoscroll.nvim',
    config = function ()
      require('neoscroll').setup()
    end
  }

  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    config = function()
      require("gitsigns").setup()
    end
  }
  use { 'sindrets/diffview.nvim', requires = {'nvim-lua/plenary.nvim', "nvimsindrets/diffview.nvim"}, config = function()
    local diffview = require('diffview')
    vim.keymap.set("n", "<leader>go", ":DiffviewOpen<CR>")
    vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>")
    diffview.setup()

    local diffviewOpen = false
    local toggleDiffview = function ()
      if not diffviewOpen then
        diffviewOpen = true
        vim.cmd(":DiffviewOpen")
      else
        diffviewOpen = false
        vim.cmd(":DiffviewClose")
      end
    end
    vim.keymap.set("n", "<leader>gd", toggleDiffview)

  end}

  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim', config = function ()
    require('neogit').setup({
      integrations = {
        diffview = true
      }
    })
    vim.keymap.set("n", "<leader>gg", ":Neogit<CR>")
  end }
  -- Lua
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use "jayp0521/mason-nvim-dap.nvim"

  use {
    'mfussenegger/nvim-dap'
  }

  use {
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"}
  }



  -- Treesitter related plugins
  use { 'nvim-treesitter/nvim-treesitter-context', }
  use 'nvim-treesitter/playground'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- Lua
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  -- END


  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  use 'github/copilot.vim'

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
    end
  }

  use 'nvim-lua/plenary.nvim'
  use 'ThePrimeagen/harpoon' -- config in telescope and harpoon config files

  use {
    "cbochs/portal.nvim",
    requires = {
      "cbochs/grapple.nvim",  -- Optional: provides the "grapple" query item
      "ThePrimeagen/harpoon", -- Optional: provides the "harpoon" query item
    },
  }
end)
