
  return {
    'NeogitOrg/neogit',
    lazy = true,
    cmd = "Neogit",
    keys = {
      "<leader>gg"
    },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function ()
      require('neogit').setup({
        integrations = {
          diffview = true
        }
      })
      vim.keymap.set("n", "<leader>gg", ":Neogit<CR>")
    end
  }
