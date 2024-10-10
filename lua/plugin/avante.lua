return {
  "yetone/avante.nvim",
  enable = false,
  keys = {
    { "<leader>ae", mode = { "n", "v" }, desc = "Avante Edit" },
    { "<leader>ac", mode = { "n", "v" }, desc = "Avante Chat" },
    { "<leader>as", mode = { "n", "v" }, desc = "Avante Suggest" },
    { "<leader>ar", mode = { "n", "v" }, desc = "Avante Rewrite" },
    { "<leader>af", mode = { "n", "v" }, desc = "Avante Fix" },
    { "<leader>at", mode = { "n", "v" }, desc = "Avante Test" },
    { "<leader>ad", mode = { "n", "v" }, desc = "Avante Diff" },
    { "<leader>aa", mode = { "n", "v" }, desc = "Avante Ask" },
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
          auto_suggestions = true,
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

    local avante = require("avante")
    vim.keymap.set({'n', 'v'}, '<leader>ae', avante.edit, { noremap = true, silent = true, desc = "Avante Edit" })
    vim.keymap.set({'n', 'v'}, '<leader>ac', avante.chat, { noremap = true, silent = true, desc = "Avante Chat" })
    vim.keymap.set({'n', 'v'}, '<leader>as', avante.suggest, { noremap = true, silent = true, desc = "Avante Suggest" })
    vim.keymap.set({'n', 'v'}, '<leader>ar', avante.rewrite, { noremap = true, silent = true, desc = "Avante Rewrite" })
    vim.keymap.set({'n', 'v'}, '<leader>af', avante.fix, { noremap = true, silent = true, desc = "Avante Fix" })
    vim.keymap.set({'n', 'v'}, '<leader>at', avante.test, { noremap = true, silent = true, desc = "Avante Test" })
    vim.keymap.set({'n', 'v'}, '<leader>ad', avante.diff, { noremap = true, silent = true, desc = "Avante Diff" })
    vim.keymap.set({'n', 'v'}, '<leader>aa', avante.ask, { noremap = true, silent = true, desc = "Avante Ask" })
  end
}
