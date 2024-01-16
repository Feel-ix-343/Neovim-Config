return {
  {'lewis6991/gitsigns.nvim', event = "VeryLazy", opts = {}},
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
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
}


