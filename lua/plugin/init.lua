return {
  {'tpope/vim-obsession', lazy = true, cmd = "Obsession"},
  { 'karb94/neoscroll.nvim', event = "VeryLazy", opts = {} },
  {'lewis6991/gitsigns.nvim', event = "VeryLazy", opts = {}},
  -- Lua
  {
    "folke/which-key.nvim",
    opts = {}
  },

  'github/copilot.vim',

    {'j-hui/fidget.nvim', lazy = true, opts = {}, event = "VeryLazy" },
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
}


