return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {-- lazy loaded
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    'JoosepAlviste/nvim-ts-context-commentstring',
    -- additional parser
    {"nushell/tree-sitter-nu"},
    {
      "chrisgrieser/nvim-various-textobjs",
      lazy = false,
      opts = { useDefaultKeymaps = true },
    },
  },

  build = ":TSUpdate",


  --event = "BufReadPre",
  config = function ()
    vim.g.skip_ts_context_commentstring_module = true
    local treesitter = require'nvim-treesitter.configs'
    treesitter.setup {
      -- ensure_installed = "all",
      highlight = {
        enable = true,
        disable = {
          "markdown" -- slow
        },
        -- additional_vim_regex_highlighting = { "markdown" }
        additional_vim_regex_highlighting = false
      },
      indent = {
        enable = true
      },
    }

  end
}

