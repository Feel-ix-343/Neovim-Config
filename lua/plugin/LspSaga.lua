-- KEY COMMANDS ARE LOCATED IN THE LSPCONFIG ONATTACH FUNCTION
return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "mason-lspconfig.nvim"
  },
  opts = {
  },
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        -- currently only round theme
        theme = 'round',
        -- border type can be single,double,rounded,solid,shadow.
        border = 'solid',
        winblend = (function() if vim.g.neovide then return 70 else return 0 end end)(),
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

    })
  end

}


