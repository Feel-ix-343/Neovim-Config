
return {
  {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    dependencies = {
      'linrongbin16/lsp-progress.nvim',
      "ecthelionvi/NeoComposer.nvim"
    },
    event = "VeryLazy",
    config = function ()
      require('lualine').setup {
        options = {
          theme = 'auto',
          icons_enabled = true,
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_c = {
            { require('NeoComposer.ui').status_recording },
            require("lsp-progress").progress,
          },
          lualine_x = {
            "buffers"
          }
        }
      }
    end
  },
  {
    'linrongbin16/lsp-progress.nvim',
    event = { 'VeryLazy' },
    config = function()
      require('lsp-progress').setup()
      -- listen to user event and trigger lualine refresh
      vim.cmd([[
        augroup lualine_augroup
            autocmd!
            autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
        augroup END
      ]])
    end
  }
}
