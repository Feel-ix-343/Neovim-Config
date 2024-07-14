return {
  {'lewis6991/gitsigns.nvim', event = "VeryLazy", opts = {}, keys = {
    {"<leader>ga", ":Gitsigns stage_hunk<CR>"}
  }},
  -- Lua

  {
    "numToStr/Comment.nvim",
    --lazy = true,
    keymaps = {
      "gcc",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      })
    end
  },

  {
    "CamdenClark/flyboy",
    keys = {
      {"<leader>gpt", ":FlyboyOpen<CR>"},
      {"<leader>g4", ":FlyboySwitchModel gpt-4<CR>"},
      {"<leader>gs", ":FlyboySendMessage<CR>"},
    }
  },

  {
    'folke/noice.nvim',
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require("noice").setup({

        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
         },
          progress = {
            enabled = true,
            throttle = 1 / 10,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
          }
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split

          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })

      vim.keymap.set({ "n", "i", "s" }, "<c-d>", function()
        if not require("noice.lsp").scroll(4) then
          return "<c-d>"
        end
      end, { silent = true, expr = true })

      vim.keymap.set({ "n", "i", "s" }, "<c-u>", function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-u>"
        end
      end, { silent = true, expr = true })

    end
  },
  "b0o/schemastore.nvim",
  {
    'MeanderingProgrammer/markdown.nvim',
    enabled = false,
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup({
        conceal = {
          rendered = 0
        }
      })
    end,
  },
  'JojoMakesGames/git-remote-url.nvim',
  {"romainl/vim-qf"},
}


