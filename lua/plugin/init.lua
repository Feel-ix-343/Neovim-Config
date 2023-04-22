return {
  {'tpope/vim-obsession', lazy = true, cmd = "Obsession"},
  { 'karb94/neoscroll.nvim', event = "VeryLazy", opts = {} },
  {'lewis6991/gitsigns.nvim', event = "VeryLazy", opts = {}},
  -- Lua
  {
    "folke/which-key.nvim",
    opts = {}
  },

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
  "dkarter/bullets.vim",
  {
    "epwalsh/obsidian.nvim",
    opts = {
      dir = "~/Notes/",
      completion =  {
        nvim_cmp = true
      }
    },
    cmd = "LoadObsidian", --this doesn't do anything but load the plugin
  },
  "dhruvasagar/vim-table-mode",
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
}


