
local telescope = require('telescope')
telescope.setup({
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
})
vim.keymap.set("n", "<leader>tr", require('telescope.builtin').lsp_references, {noremap = true})
vim.keymap.set("n", "<leader>ts", require('telescope.builtin').live_grep, {noremap = true})
vim.keymap.set("n", "<leader>tf", require("telescope.builtin").find_files, {noremap = true})
vim.keymap.set("n", "<leader>tg", require("telescope.builtin").git_files, {noremap = true})
vim.keymap.set("n", "<leader>tk", require("telescope.builtin").keymaps, {noremap=true})
