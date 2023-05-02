return {
  {'tpope/vim-obsession', lazy = true, cmd = "Obsession"},
  --{ 'karb94/neoscroll.nvim', event = "VeryLazy", opts = {} },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
  },
  {'lewis6991/gitsigns.nvim', event = "VeryLazy", opts = {}},
  -- Lua

  -- {'j-hui/fidget.nvim', lazy = true, opts = {}, event = "VeryLazy" },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    keymaps = {
      "gcc",
    },
    config = function()
      require("Comment").setup()
    end
  },

  {
    "dkarter/bullets.vim",
    event = "BufReadPre **.md"
  },
  "dhruvasagar/vim-table-mode",
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},

  {
    "preservim/vim-pencil",
    cmd = "PencilEnable"
  },
  -- "junegunn/limelight.vim",
  -- "junegunn/goyo.vim"
  {
    'edluffy/hologram.nvim',
    opts = {
      auto_display = true
    }
  }
}


