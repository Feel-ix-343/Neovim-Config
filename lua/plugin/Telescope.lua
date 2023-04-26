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
    "<leader>to",
    "<leader>tb",
    "<leader>tl"
  },
  config = function (plugin, opts)
    require("telescope").setup({
      defaults = {
        winblend = (function() if vim.g.neovide then return 90 else return 0 end end)()
      },
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
    vim.keymap.set("n", "<leader>to", require("telescope.builtin").lsp_document_symbols, {noremap=true})
    vim.keymap.set("n", "<leader>tb", require("telescope.builtin").buffers, {noremap=true})
    vim.keymap.set("n", "<leader>tl", require("telescope.builtin").resume, {noremap=true})

    require('telescope').load_extension("harpoon")
    require('telescope').load_extension('macros')
    vim.keymap.set("n", "<leader>th", require("telescope._extensions.marks"), {noremap = true})
  end
}

