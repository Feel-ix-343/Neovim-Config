
return {
  {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    dependencies = {
      'linrongbin16/lsp-progress.nvim',
      "ecthelionvi/NeoComposer.nvim"
    },
    --event = "VeryLazy",
    config = function ()
      local colors = {
        fg = "#838994",
        bg = "none"
      }
      require('lualine').setup {
        options = {
          theme = {
            -- Black and gray colors
            normal = {
              a = { fg = colors.fg, bg = colors.bg },
              b = { fg = colors.fg, bg = colors.bg },
              c = { fg = colors.fg, bg = colors.bg },
            },
            insert = {
              a = { fg = colors.fg, bg = colors.bg },
              b = { fg = colors.fg, bg = colors.bg },
            },
            visual = {
              a = { fg = colors.fg, bg = colors.bg },
              b = { fg = colors.fg, bg = colors.bg },
            },
            command = {
              a = { fg = colors.fg, bg = colors.bg },
              b = { fg = colors.fg, bg = colors.bg },
            },
            replace = {
              a = { fg = colors.fg, bg = colors.bg },
              b = { fg = colors.fg, bg = colors.bg },
            },
          },
          icons_enabled = true,
          -- component_separators = { left = '', right = ''},
          -- section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_c = {
            { require('NeoComposer.ui').status_recording },
            (
              function()
                if not (vim.bo.filetype == "markdown") then
                  return require("lsp-progress").progress
                end
              end
            )()
          },
          lualine_x = {
            {"filename", path = 1}
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
