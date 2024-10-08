return {
  "yetone/avante.nvim",
  keys = {
    { "<leader>E", mode = { "n", "v" } },
  },
  build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below is optional, make sure to setup it properly if you have lazy=true
    -- {
    --   'MeanderingProgrammer/render-markdown.nvim',
    --   opts = {
    --     -- file_types = { "markdown", "Avante" },
    --     file_types = {  "Avante" },
    --   },
    --   ft = { "markdown", "Avante" },
    -- },
  },

  config = function()
    -- views can only be fully collapsed with the global statusline
    vim.opt.laststatus = 3
    -- Default splitting will cause your main splits to jump when opening an edgebar.
    -- To prevent this, set `splitkeep` to either `screen` or `topline`.
    vim.opt.splitkeep = "screen"


    require("avante").setup(
      {
        ---@alias Provider "openai" | "claude" | "azure"  | "copilot" | [string]
        provider = "claude",
        behaviour = {
          auto_suggestions = false, -- Experimental stage
          auto_set_highlight_group = true,
          auto_set_keymaps = false,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = false,
        },
        -- claude = {
        --   endpoint = "https://api.anthropic.com",
        --   model = "claude-3-5-sonnet-20240620",
        --   temperature = 0,
        --   max_tokens = 4096,
        -- },
        -- copilot = {
        --   endpoint = "https://api.githubcopilot.com",
        --   model = "gpt-4o-2024-05-13",
        --   proxy = nil, -- [protocol://]host[:port] Use this proxy
        --   allow_insecure = false, -- Allow insecure server connections
        --   timeout = 30000, -- Timeout in milliseconds
        --   temperature = 0,
        --   max_tokens = 4096,
        -- },
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o",
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 4096,
          ["local"] = false,
        },
        -- Removed mappings configuration
        hints = { enabled = true },
        windows = {
          wrap = true, -- similar to vim.o.wrap
          width = 30, -- default % based on available width
          sidebar_header = {
            align = "center", -- left, center, right for title
            rounded = false,
          },
        },
        highlights = {
          ---@type AvanteConflictHighlights
          diff = {
            current = "DiffText",
            incoming = "DiffAdd",
          },
        },
        --- @class AvanteConflictUserConfig
        diff = {
          debug = false,
          autojump = true,
          ---@type string | fun(): any
          list_opener = "copen",
        },
      }
    )

    -- Set up the manual keybindings for Avante edit
    local function avante_edit()
      if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
        vim.cmd('normal! y')
        require('avante').edit(vim.fn.getreg('"'))
      else
        require('avante').edit()
      end
    end

    vim.keymap.set({'n', 'v'}, '<leader>E', avante_edit, { noremap = true, silent = true, desc = "Avante Edit" })
  end
}
