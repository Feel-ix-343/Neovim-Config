return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    "<leader>xx",
    "<leader>xw",
    "<leader>xd",
    "<leader>xl",
    "<leader>xq",
    "gR",
  },
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    require( "trouble" ).setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }

    -- Lua
    vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
      {silent = true, noremap = true}
    )
    vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
      {silent = true, noremap = true}
    )
    vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
      {silent = true, noremap = true}
    )
    vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
      {silent = true, noremap = true}
    )
    vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
      {silent = true, noremap = true}
    )
    vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
      {silent = true, noremap = true}
    )
  end
}
