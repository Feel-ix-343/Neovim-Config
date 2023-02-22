
return { 
  "folke/todo-comments.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = function()
    require("todo-comments").setup {
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--glob=!node_modules",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    }
  end
}

