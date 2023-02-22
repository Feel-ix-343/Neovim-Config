return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {-- lazy loaded
    {'nvim-treesitter/nvim-treesitter-textobjects', lazy = true},
  },
  config = function ()
    local treesitter = require'nvim-treesitter.configs'
    treesitter.setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = {
        enable = true
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ia"] = "@attribute.inner",
            ["aa"] = "@attribute.outer",
            ["ie"] = "@block.inner",
            ["ae"] = "@block.outer",
            ["ic"] = "@call.inner",
            ["ac"] = "@call.outer",
            ["iC"] = "@class.inner",
            ["aC"] = "@class.outer",
            ["ad"] = "@comment.outer",
            ["iF"] = "@conditional.inner",
            ["aF"] = "@conditional.outer",
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["ip"] = "@parameter.inner",
            ["ap"] = "@parameter.outer",
            ["as"] = "@statement.outer",
            ["iS"] = "@scopename.inner",
            ["aS"] = "@scopename.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    }

  end
}

