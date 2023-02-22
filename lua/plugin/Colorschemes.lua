return {
  {
    "catppuccin/nvim",
    config = function ()
      require('catppuccin').setup({
        transparent_background=false,
        integrations = {
          cmp = true,
          gitsigns = true,
          barbar = true,
          lsp_saga = true,
          mason = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
          nvimtree = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          treesitter_context = true,
          treesitter = true,
          telescope = true,
          which_key = true,
          notify = true
        }
      })
    end,
    priority = 1000;
  },
  {
    'folke/tokyonight.nvim',
    opts = {
      transparent = false
    },
    priority = 1000;
  },
  {
    "sainnhe/everforest",
    priority = 1000
  },
  {
    "sainnhe/sonokai",
    priority = 1000
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000
  }
}
