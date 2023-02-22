-- KEY COMMANDS ARE LOCATED IN THE LSPCONFIG ONATTACH FUNCTION
return {
  "glepnir/lspsaga.nvim",
  event = "UIEnter",
  opts = {
    symbol_in_winbar = {
      enable = true,
    },
    ui = {
      -- currently only round theme
      theme = 'round',
      -- border type can be single,double,rounded,solid,shadow.
      border = 'solid',
      winblend = 0,
      expand = '',
      collapse = '',
      preview = ' ',
      code_action = '',
      diagnostic = '',
      incoming = ' ',
      outgoing = ' ',
      colors = {
        --float window normal bakcground color
        --- normal_bg = '',
        --title background color
      },
      -- kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },
  }
}


