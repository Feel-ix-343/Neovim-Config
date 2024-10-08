
if vim.filetype and vim.filetype.add then
  vim.filetype.add({extension = {typ = "typst", ua = "uiua"}})
elseif vim.filetype and vim.filetype.plugin and vim.filetype.plugin.add then
  vim.filetype.plugin.add({extension = {typ = "typst", ua = "uiua"}})
else
  vim.cmd([[
    autocmd BufRead,BufNewFile *.typ setfiletype typst
    autocmd BufRead,BufNewFile *.ua setfiletype uiua
  ]])
end
local on_attach = function(client, bufnr)
  local keymap = vim.keymap.set
  keymap("n", "gh", ":Lspsaga finder<CR>", { silent = true })
  keymap({"n", "v"}, "<leader>a", vim.lsp.buf.code_action, { silent = true })
  keymap("n", "gr", vim.lsp.buf.rename, { silent = true })
  keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", {silent = true})

  keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
  -- keymap("n","gd", vim.lsp.buf.definition) -- this is now a part of telescope

  keymap("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>")
  keymap("n","gt", "<cmd>Lspsaga goto_type_definition<CR>")

  -- Show line diagnostics
  -- You can pass argument ++unfocus to
  -- unfocus the show_line_diagnostics floating window
  keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

  -- Show cursor diagnostics
  -- Like show_line_diagnostics, it supports passing the ++unfocus argument
  keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

  -- Show buffer diagnostics
  keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
  keymap("n", "[E", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  keymap("n", "]E", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  -- keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })
  keymap("n", "K", vim.lsp.buf.hover, { silent = true })
  keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
  keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

  -- Call hierarchy
  keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
  keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

  keymap("i", "<C-K>", vim.lsp.buf.signature_help, { silent = true })


  keymap("n", "<leader>Lb", "<cmd>TexlabBuild<CR>", {desc = "Build the latex document"})
  keymap("n", "<leader>Lf", "<cmd>TexlabForward<CR>", {desc = "Open PDF viewer of the latex document"})

  local inlay_hint_enable = false
  vim.lsp.inlay_hint.enable(inlay_hint_enable)
  keymap("n",
    "<leader>i",
    function()
      inlay_hint_enable = not inlay_hint_enable
      vim.lsp.inlay_hint.enable(inlay_hint_enable)
    end,
    {desc = "Toggle inlay hint"})
  -- vim.lsp.buf.inlay_hint(bufnr, true)

  --vim.lsp.codelens.refresh()
  local function check_codelens_support()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, c in ipairs(clients) do
      if c.server_capabilities.codeLensProvider then
        return true
      end
    end
    return false
  end
  keymap("n", "<leader>R", vim.lsp.codelens.run, {desc = "Run code lens"})

  -- refresh codelens on TextChanged and InsertLeave as well
  vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
    buffer = bufnr,
    callback = function ()
      if check_codelens_support() then
        vim.lsp.codelens.refresh({bufnr = 0})
      end
    end
  })
  -- trigger codelens refresh
  vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })

  -- setup Markdown Oxide daily note commands
  if client.name == "markdown_oxide" then

    vim.api.nvim_create_user_command(
      "Daily",
      function(args)
        local input = args.args

	vim.lsp.buf.execute_command({command="jump", arguments={input}})

      end,
      {desc = 'Open daily note', nargs = "*"}
    )
  end


end




-- Servers to preconfigure. Others are manually configured in lspconfig setup
local servers = {
  'clangd',
  'pyright',
  'html',
  'cssls',
  "lua_ls",
  "rust_analyzer",
  "ts_ls",
  "bashls",
  "astro",
  "tailwindcss",
  "sqlls",
  "jsonls",
  "gopls",
  "nil_ls"
}






return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {"<leader>ss", "<cmd>LspStart<CR>"},
      {"<leader>sS", "<cmd>LspStop<CR>"},
      {"<leader>sr", "<cmd>LspRestart<CR>"}
    },
    cmd = "LspStart",
    lazy = true,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navbuddy",
      "simrat39/rust-tools.nvim"
    },
    config = function()


      vim.keymap.set("n", "<leader>si", "<cmd>LspInfo<CR>")

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      capabilities.workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      }

      if vim.env.MOXIDE_DEBUG then
        vim.lsp.set_log_level("debug")
      end

      require("lspconfig").markdown_oxide.setup({
        cmd = {(function()
          if vim.env.MOXIDE_DEBUG then
            return "/home/felix/coding/LargerIdeas/MarkdownOxide/markdown-oxide/target/debug/markdown-oxide"
          elseif vim.env.MOXIDE_BIN then
            return "markdown-oxide"
          else
            return "/home/felix/coding/LargerIdeas/MarkdownOxide/markdown-oxide/target/release/markdown-oxide"
          end
        end)()},
        root_dir = function(fname, _)
          return require("lspconfig").util.root_pattern('.obsidian', '.moxide.toml', '.git')(fname) or vim.uv.cwd()
        end,
        capabilities =  vim.tbl_deep_extend(
          'force',
          capabilities,
          {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          }
        ),
        on_attach = on_attach,
        commands = {
          Today = {
            function()
              vim.lsp.buf.execute_command({command="jump", arguments={"today"}})
            end,
            description = "Open today's daily note"
          },
          Tomorrow = {
            function()
              vim.lsp.buf.execute_command({command="jump", arguments={"tomorrow"}})
            end,
            description = "Open tomorrow's daily note"
          },
          Yesterday = {
            function()
              vim.lsp.buf.execute_command({command="jump", arguments={"yesterday"}})
            end,
            description = "Open yesterday's daily note"
          },
        }
      })


      require("lspconfig").hls.setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
      require("lspconfig").uiua.setup({
        on_attach = function (client, bufnr)
          vim.keymap.set("n", "<leader>r", "<cmd>write<CR><cmd>!uiua run --no-format<CR>")
          vim.keymap.set("n", "<leader>f", "<cmd>!uiua fmt<CR><cmd>e<CR>")
          on_attach(client, bufnr)
        end,
        capabilities = capabilities
      })

      -- Setup for preconfigured servers
      for _, lsp in ipairs(servers) do
        require('lspconfig')[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- Specific configurations
      require('lspconfig').ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      })

      require('lspconfig').nushell.setup({
        cmd = {"/home/felix/coding/OpenSource/nushell/target/release/nu", "--lsp"},
        on_attach = on_attach,
        capabilities = capabilities,
      })


      -- LSP Icons and highlighting for saga
      local signs = {
        Error = " ",
        Warn  = " ",
        Hint  = "",
        Info  = " ",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end



    end

  },


  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim"
    },
    lazy = true,
    keys = {
      { "<leader>o", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
    },
    config = function()
      local navbuddy = require('nvim-navbuddy')
      local actions = require('nvim-navbuddy.actions')

      navbuddy.setup({
        lsp = {
          auto_attach = true,
        }
      })
    end
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup({
        lsp = {
          enabled = true,
          on_attach = on_attach,
          actions = true,
          completion = true,
          hover = true,
        },
        completion = {
          crates = {
            enabled = true, -- disabled by default
            max_results = 10, -- The maximum number of search results to display
            min_chars = 1 -- The minimum number of charaters to type before completions begin appearing
          }
        }
      })
    end,
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(client, bufnr)
        on_attach(client, bufnr)
      end

      metals_config.settings = {
        showImplicitArguments = true,
        showImplicitConversionsAndClasses = true,
        useGlobalExecutable = true,
        showInferredType = true
      }

      return metals_config
    end,
    config = function(_, metals_config)
      require("metals").initialize_or_attach(metals_config)
    end
  }
}
