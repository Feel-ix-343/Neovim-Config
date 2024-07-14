return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = {  "nvim-lua/plenary.nvim" }
    },
    "debugloop/telescope-undo.nvim",
  },
  lazy = true,
  cmd = "Telescope",
  keys = {
    "<leader>ti",
    "<leader>ts",
    "<leader>tf",
    "<leader>tg",
    "<leader>tk",
    "<leader>to",
    "<leader>tb",
    "<leader>tl",
    "<leader>te",
    "<leader>tu",
    "<leader>tc",
    "<leader>td",
    "gd"
  },
  config = function (plugin, opts)


    local actions = require("telescope.actions")

    local open_with_trouble = require("trouble.sources.telescope").open
    -- Use this to add more results without clearing the trouble list
    local add_to_trouble = require("trouble.sources.telescope").add

    require("telescope").setup({
      defaults = require("telescope.themes").get_ivy {
        winblend = (function() if vim.g.neovide then return 40 else return 0 end end)(),
        layout_config = {
          height = 0.6
        },
        mappings = {
          i = { ["<c-t>"] = open_with_trouble },
          n = { ["<c-t>"] = open_with_trouble },
        }
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
        buffers = {
          sort_mru = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        }
      },
    })

    vim.keymap.set("n", "<leader>ti", require('telescope.builtin').lsp_references, {noremap = true})
    vim.keymap.set("n", "<leader>ts", require('telescope.builtin').live_grep, {noremap = true})
    vim.keymap.set("n", "<leader>te", require("telescope.builtin").find_files, {noremap = true})
    vim.keymap.set("n", "<leader>tg", require("telescope.builtin").git_files, {noremap = true})
    vim.keymap.set("n", "<leader>tk", require("telescope.builtin").keymaps, {noremap=true})
    vim.keymap.set("n", "<leader>to", require("telescope.builtin").lsp_document_symbols, {noremap=true})
    vim.keymap.set("n", "<leader>tO", require("telescope.builtin").lsp_workspace_symbols, {noremap=true})
    vim.keymap.set("n", "<leader>tb", require("telescope.builtin").buffers, {noremap=true})
    vim.keymap.set("n", "<leader>tc", require("telescope.builtin").colorscheme, {noremap=true})
    vim.keymap.set("n", "<leader>tl", require("telescope.builtin").resume, {noremap=true})
    vim.keymap.set("n", "<leader>td", require('telescope.builtin').lsp_definitions, {noremap=true})
    vim.keymap.set("n", "gd", require('telescope.builtin').lsp_definitions, {noremap=true})
    vim.keymap.set("n", "<leader>tu", require('telescope').extensions.undo.undo)

    require('telescope').load_extension("harpoon")
    -- require('telescope').load_extension('macros')
    require('telescope').load_extension('file_browser')
    require("telescope").load_extension("undo")
    vim.keymap.set("n", "<leader>th", require("telescope._extensions.marks"), {noremap = true}) vim.keymap.set("n", "<leader>th", require("telescope._extensions.marks"), {noremap = true})

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function(args)
          vim.wo.wrap = true
      end,
    })
  end
}

