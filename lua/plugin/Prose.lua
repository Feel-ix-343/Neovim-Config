return {
  {
    "dkarter/bullets.vim",
    event = "BufReadPre **.md"
  },

  {
    "preservim/vim-pencil",
    ft = {"markdown", "tex", "bib"},
    config = function()
      vim.cmd[[let g:pencil#conceallevel = 0]] -- no conceal
      vim.cmd[[autocmd Filetype markdown PencilSoft]]
      vim.cmd[[autocmd Filetype tex Pencil]]
      vim.cmd[[autocmd Filetype bib Pencil]]

      vim.cmd[[autocmd Filetype markdown set nobreakindent]] -- this is set by pencil and its slow af
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    event = { "BufReadPre /home/felix/Notes/**.md" },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- Optional, for completion.
      "hrsh7th/nvim-cmp",

      -- Optional, for search and quick-switch functionality.
      "nvim-telescope/telescope.nvim",

      -- Optional, an alternative to telescope for search and quick-switch functionality.
      -- "ibhagwan/fzf-lua"

      -- Optional, another alternative to telescope for search and quick-switch functionality.
      -- "junegunn/fzf",
      -- "junegunn/fzf.vim"
    },
    opts = {
      dir = "~/Notes/",  -- no need to call 'vim.fn.expand' here

      ui = {
        enable = false
      },

      -- Optional, completion.
      completion = {
        nvim_cmp = false,  -- if using nvim-cmp, otherwise set to false
      },

      -- Optional, customize how names/IDs for new notes are created.
      note_id_func = function(title)
        return title .. ".md"
      end,

      -- Optional, set to true if you don't want Obsidian to manage frontmatter.
      disable_frontmatter = true,

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({"open", url})  -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
      -- see also: 'follow_url_func' config option above.
      -- vim.keymap.set("n", "<leader>gf", function()
      --   if require("obsidian").util.cursor_on_markdown_link() then
      --     return "<cmd>ObsidianFollowLink<CR>"
      --   else
      --     return "gf"
      --   end
      -- end, { noremap = false, expr = true })

      vim.keymap.set("n", "<leader>O", "<cmd>ObsidianOpen<CR>")
    end,
  }
}
