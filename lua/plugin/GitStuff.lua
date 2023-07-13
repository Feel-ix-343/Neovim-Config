
return { 
  {
    'sindrets/diffview.nvim',
    cmd = "DiffviewOpen",
    keys = {
      "<leader>go",
      "<leader>gc",
      "<leader>gd"
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      "diffview.nvim"
    },
    config = function()
      local diffview = require('diffview')
      vim.keymap.set("n", "<leader>go", ":DiffviewOpen<CR>")
      vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>")

      diffview.setup()

      local diffviewOpen = false
      local toggleDiffview = function ()
        if not diffviewOpen then
          diffviewOpen = true
          vim.cmd(":DiffviewOpen")
        else
          diffviewOpen = false
          vim.cmd(":DiffviewClose")
        end
      end
      vim.keymap.set("n", "<leader>gd", toggleDiffview)

    end
  },
  {
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
}
