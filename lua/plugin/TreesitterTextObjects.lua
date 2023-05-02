return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = {
    'nvim-treesitter/nvim-treesitter'
  },
  event = "VeryLazy",
  config = function()
    -- require('vim.treesitter.query').set_query("markdown", "textobjects", "(inline) @inline")
    require'nvim-treesitter.configs'.setup {
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
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            ["as"] = "@statement.outer",
            ["iS"] = "@scopename.inner",
            ["aS"] = "@scopename.outer",

            ["P"] = "@par.inner",
            ["H"] = "@section",

            -- markdown inline lists?

          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = "@class.outer",
            ["]h"] = "@heading",
            ["]p"] = "@par.inner"
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[["] = "@class.outer",
            ["[h"] = "@heading",
            ["[p"] = "@par.inner"
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<C-N>"] = {query = {"@list_item", "@parameter.inner"}}
          },
          swap_previous = {
            ["<C-P>"] = {query = {"@list_item", "@parameter.inner"}}
          },
        },
      }
    }

    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- vim.cmd[[autocmd FileType markdown nmap _ <cmd>TSTextobjectGotoPreviousStart @par.inner<CR>]]
  end
}
