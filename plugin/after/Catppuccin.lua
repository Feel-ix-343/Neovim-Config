
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
