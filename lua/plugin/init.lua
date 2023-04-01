return {
  {'tpope/vim-obsession', lazy = true, cmd = "Obsession"},
  { 'karb94/neoscroll.nvim', opts = {} },
  {'lewis6991/gitsigns.nvim', opts = {}},
  -- Lua
  {
    "folke/which-key.nvim",
    opts = {}
  },

  'github/copilot.vim',

    {'j-hui/fidget.nvim', lazy = true, opts = {}, event = "UIEnter" },
  {
    'glepnir/dashboard-nvim',
    event = 'UIEnter',
    opts = {
      -- config
    },
    dependencies = {
      {'nvim-tree/nvim-web-devicons'}
    }
  },
  {
    "epwalsh/obsidian.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      dir = "~/Notes",
      completion = {
        nvim_cmp = true
      }
    },
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
}


