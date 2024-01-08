return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {-- lazy loaded
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    'JoosepAlviste/nvim-ts-context-commentstring',
  },


  --event = "BufReadPre",
  config = function ()
    vim.g.skip_ts_context_commentstring_module = true
    local treesitter = require'nvim-treesitter.configs'
    treesitter.setup {
      -- ensure_installed = "all",
      highlight = {
        enable = true,
        --additional_vim_regex_highlighting = { "markdown" }
      },
      indent = {
        enable = true
      },
    }

  end
}

