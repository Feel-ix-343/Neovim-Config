
return {
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  event = "VeryLazy",
  config = function ()
    require('lualine').setup {
      options = {
        theme = 'auto',
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
    }
  end
}
