
-- Server to preconfigure. others are manually configured in lspconfig setup
local servers = {
  'clangd',
  'pyright',
  'html',
  'cssls',
  "lua_ls",
  "rust_analyzer",
  "tsserver",
  "bashls",
  "astro",
  "marksman",
  "tailwindcss",
  "sqlls",
  "jsonls"
}





return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "UIEnter",
    dependencies = {
      'folke/neodev.nvim',
      "mason.nvim",
      "mason-lspconfig.nvim",
      "null-ls.nvim",
      "mason-null-ls.nvim",
      "hrsh7th/cmp-nvim-lsp",
      'simrat39/rust-tools.nvim',
      "nvim-navbuddy",
      {
        'scalameta/nvim-metals',
        dependencies = {
          "nvim-lua/plenary.nvim"
        }
      }
    },
    config = function()


      local on_attach = function(client, bufnr)
        local keymap = vim.keymap.set
        keymap("n", "gh", ":Lspsaga lsp_finder<CR>", { silent = true })
        keymap("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
        keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

        keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
        keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")


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
        keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
        keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
        keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

        -- Call hierarchy
        keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
        keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

        keymap("i", "<C-K>", vim.lsp.buf.signature_help, { silent = true })

        local navbuddy = require('nvim-navbuddy')
        navbuddy.attach(client, bufnr)
      end



      local lspconfig = require('lspconfig')

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities
        }
      end


      -- rust
      require("rust-tools").setup({
        tools = {
          auto = true,
        },
        server = {
          on_attach = on_attach
        },
        dap = { -- Enabling rust to use codelldb; This is related to the dap functions
          adapter = require('rust-tools.dap').get_codelldb_adapter(
            "codelldb",
            vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so" -- TODO: Set this yoruself
          )
        }
      })

      -- Metals
      vim.opt_global.shortmess:remove("F")
      local metals_config = require("metals").bare_config()

      -- Example of settings
      metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        showInferredType = true,
        superMethodLensesEnabled = true,
      }

      -- starting metals
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
          on_attach()
          require("metals").initialize_or_attach(metals_config)
          require('metals').setup_dap()
        end,
        group = nvim_metals_group,
      })


      -- LUA
      -- Example custom server
      -- Make runtime files discoverable to the server

      require('neodev').setup({}) -- Such a life saver
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            },
            workspace = {
              checkThirdParty = false
            }
          },
        },
      }

      -- LSP Icons and highlighting for saga
      local signs = {
        Error = " ",
        Warn  = " ",
        Hint  = "ﴞ",
        Info  = " ",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end



      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.offsetEncoding = { "utf-16" }
      require("lspconfig").clangd.setup({ capabilities = capabilities, on_attach = on_attach })
    end

  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "UIEnter",
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")

      return {
        sources = {
          null_ls.builtins.code_actions.gitsigns.with({
            config = {
              filter_actions = function(title)
                return title:lower():match("blame") == nil -- filter out blame actions
              end,
            },
          }),
          null_ls.builtins.completion.tags,
        }
      }
    end
  },




  {
    "jayp0521/mason-null-ls.nvim",
    event = "UIEnter",
    dependencies = { "mason.nvim" },
    config = function ()
      require("mason-null-ls").setup({
        automatic_setup = {
          exclude = {"clangd"}
        }
      })
      require("mason-null-ls").setup_handlers()
    end
  },


  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    lazy = true,
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {}
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "UIEnter",
    opts = {
      ensure_installed = servers,
      automatic_installation = true
    }
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

      navbuddy.setup({ })
    end
  }
}

