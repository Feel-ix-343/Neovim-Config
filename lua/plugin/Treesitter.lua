return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {-- lazy loaded
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  --event = "VeryLazy",
  config = function ()
    local treesitter = require'nvim-treesitter.configs'
    treesitter.setup {
      -- ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" }
      },
      indent = {
        enable = true
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      }
    }

  end
}

