return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  cmd = "Telescope",
  keys = {
    "<leader>tr",
    "<leader>ts",
    "<leader>tf",
    "<leader>tg",
    "<leader>tk",
    "<leader>to"
  },
  opts = {
    pickers = {
      colorscheme = {
        enable_preview = true
      }
    }
  },
  config = function (plugin, opts)

    vim.keymap.set("n", "<leader>tr", require('telescope.builtin').lsp_references, {noremap = true})
    vim.keymap.set("n", "<leader>ts", require('telescope.builtin').live_grep, {noremap = true})
    vim.keymap.set("n", "<leader>tf", require("telescope.builtin").find_files, {noremap = true})
    vim.keymap.set("n", "<leader>tg", require("telescope.builtin").git_files, {noremap = true})
    vim.keymap.set("n", "<leader>tk", require("telescope.builtin").keymaps, {noremap=true})
    vim.keymap.set("n", "<leader>to", require("telescope.builtin").treesitter, {noremap=true})

    require('telescope').load_extension("harpoon")
    vim.keymap.set("n", "<leader>th", require("telescope._extensions.marks"), {noremap = true})
  end
}
