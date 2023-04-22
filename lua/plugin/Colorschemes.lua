return {
  {
    "catppuccin/nvim",
    config = function ()
      require('catppuccin').setup({
        transparent_background=true,
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
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      },
    }
  },
	{ "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
}
