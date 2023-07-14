return {
  {'tpope/vim-obsession', lazy = true, cmd = "Obsession"},
  --{ 'karb94/neoscroll.nvim', event = "VeryLazy", opts = {} },
  -- {
  --   'glepnir/dashboard-nvim',
  --   event = 'VimEnter',
  --   config = function()
  --     require('dashboard').setup {
  --       -- config
  --     }
  --   end,
  -- },
  {'lewis6991/gitsigns.nvim', event = "VeryLazy", opts = {}},
  -- Lua

  -- {'j-hui/fidget.nvim', lazy = true, opts = {}, event = "VeryLazy" },
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
    "ekickx/clipboard-image.nvim",
    config = function()
      require'clipboard-image'.setup {
        -- Default configuration for all filetype
        default = {
          img_dir = "images",
          img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
          affix = "<\n  %s\n>" -- Multi lines affix
        },
        -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
        -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
        -- Missing options from `markdown` field will be replaced by options from `default` field
        markdown = {
          img_dir = {""}, -- Use table for nested dir (New feature form PR #20)
          img_dir_txt = "",
        }
      }
    end
  },
  -- "junegunn/limelight.vim",
  -- "junegunn/goyo.vim"
  -- {
  --   'edluffy/hologram.nvim',
  --   config = function()
  --     require('hologram').setup{
  --       auto_display = true -- WIP automatic markdown image display, may be prone to breaking
  --     }
  --   end
  -- }
  { 
    "svermeulen/text-to-colorscheme.nvim",
    enabled = false,
    config = function()
      vim.o.background = "dark"

      require('text-to-colorscheme').setup {
        ai = {
          gpt_model = "gpt-3.5-turbo",
          openai_api_key = os.getenv("OPENAI_API_KEY")
        },
        transparent_mode = true,
        overrides = {
          SignColumn = { bg = none },
          CursorLine = { bg = none }
        }
      }

      vim.cmd([[colorscheme text-to-colorscheme]])

      vim.api.nvim_set_keymap('n', '<f9>', ':T2CAddContrast -0.1<cr>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<f10>', ':T2CAddContrast 0.1<cr>', {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<f11>', ':T2CAddSaturation -0.1<cr>', {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<f12>', ':T2CAddSaturation 0.1<cr>', {noremap = true, silent = true})

      vim.api.nvim_set_keymap('n', '<f8>', ':T2CShuffleAccents<cr>', {noremap = true, silent = true})
    end
  },
  { "https://git.sr.ht/~soywod/himalaya-vim", config = function()
    vim.g.himalaya_folder_picker = "native"
  end},
}


