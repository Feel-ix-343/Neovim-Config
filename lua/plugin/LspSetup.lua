
vim.filetype.add({extension = {typ = "typst"}})
local on_attach = function(client, bufnr)
  local keymap = vim.keymap.set
  keymap("n", "gh", ":Lspsaga lsp_finder<CR>", { silent = true })
  keymap("n", "<leader>a", ":Lspsaga code_action<CR>", { silent = true })
  keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

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

  --vim.lsp.buf.inlay_hint(bufnr, true)

end




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
  --"marksman",
  "tailwindcss",
  "sqlls",
  "jsonls"
}






return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    keys = {
      {"<leader>ss", "<cmd>LspStart<CR>"},
      {"<leader>sS", "<cmd>LspStop<CR>"}
    },
    lazy = true,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()

      vim.keymap.set("n", "<leader>si", "<cmd>LspInfo<CR>")


      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      vim.lsp.set_log_level("debug")
      local configs = require("lspconfig.configs")
      configs["obsidian_ls"] = {
        default_config = {
          root_dir = function() return vim.fn.getcwd() end,
          filetypes = {"markdown"},
          cmd = {"/home/felix/coding/LargerIdeas/ObsidianLS/obsidian-ls/target/release/obsidian-ls"}
        },
        on_attach = on_attach,
        capabilities = capabilities,
      }
      require("lspconfig").obsidian_ls.setup({})

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
    end

  },

  {
    "jayp0521/mason-null-ls.nvim",
    --event = "VeryLazy",
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function ()
      -- require null-ls
      local null_ls = require("null-ls")

      require("null-ls").setup({
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

      })

      local mason_null = require("mason-null-ls")
      mason_null.setup({
        automatic_setup = true
      })
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
    dependencies = {
      "mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      'simrat39/rust-tools.nvim',
      "folke/neodev.nvim",
      "SmiteshP/nvim-navbuddy",
      "jose-elias-alvarez/typescript.nvim"
    },
    -- event = "VeryLazy",
    lazy = true,

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers, -- Installs all servers in the list
        automatic_installation = true
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end,
        ["grammarly"] = function()
          require("lspconfig").grammarly.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = {"n", "run", "16", "/home/felix/.local/share/nvim/mason/bin/grammarly-languageserver", "--stdio"},
            init_options = {clientId = "client_BaDkMgx4X19X9UxxYRCXZo"}
          }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function ()
          require("rust-tools").setup {
            tools = {
              inlay_hints = {
                auto = false
              }
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
          }
        end,
        ["lua_ls"] = function()
          -- LUA
          -- Example custom server
          -- Make runtime files discoverable to the server

          require('neodev').setup() -- Such a life saver
          require("lspconfig").lua_ls.setup {
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
        end,
        ["clangd"] = function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.offsetEncoding = { "utf-16" }
          require("lspconfig").clangd.setup({ capabilities = capabilities, on_attach = on_attach })
        end,
        ["texlab"] = function()
          require('lspconfig').texlab.setup({
            capabilities = capabilities, 
            on_attach = on_attach,
            settings = {
              texlab = {
                auxDirectory = "build",
                build = {
                  onSave = true,
                  args = {
                    '-pdflatex=lualatex', '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f', "-output-directory=build",
                  }
                },
                forwardSearch = {
                  executable = "okular",
                  args = {
                    "--unique",
                    "file:%p#src:%l%f",
                  }
                }
              }
            }
          })
        end,
        ["sqlls"] = function()
          require("lspconfig").sqlls.setup({
            capabilities = capabilities, 
            on_attach = on_attach,
            settings = {
              sqlls = {
                connections= {
                  {
                    name= "Supabase-Postgres",
                    adapter= "postgres",
                    host= "localhost",
                    port= 54322,
                    user= "postgres",
                    password= "postgres",
                    database= "postgres",
                    projectPaths= {"/home/felix/coding/LargerIdeas/Omnis/supabase/"}
                  }
                }
              }
            }
          })
        end,
        ["tsserver"] = function()
          require("typescript").setup({
            server = {
              on_attach = on_attach,
              settings = {
                javascript = {
                  inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                  },
                },
                typescript = {
                  inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                  },
                  preferences = {
                    jsxAttributeCompletionStyle = 'braces'
                  }
                },
              }
            }
          })
        end,
        ["marksman"] = function ()
          require'lspconfig'.marksman.setup{single_file_support = false}
        end,
        ["typst_lsp"] = function()
          local util = require('lspconfig.util')
          require'lspconfig'.typst_lsp.setup({
            root_dir = function(fname)
              if util.find_git_ancestor(fname) then
                return util.find_git_ancestor(fname)
              else return vim.fn.getcwd()
              end
            end,
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        ["tailwindcss"] = function()
          require'lspconfig'.tailwindcss.setup({
            filetypes = {"jsx", "tsx", "astro"},
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end
      }
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
    'scalameta/nvim-metals',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mason-null-ls.nvim",
    },
    ft = { "scala", "sbt" },
    config = function ()
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

      on_attach()
      require("metals").initialize_or_attach(metals_config)
      require('metals').setup_dap()

    end
  },
}
