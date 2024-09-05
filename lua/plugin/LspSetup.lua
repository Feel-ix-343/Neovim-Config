
vim.filetype.add({extension = {typ = "typst", ua = "uiua"}})
local on_attach = function(client, bufnr)
  local keymap = vim.keymap.set
  keymap("n", "gh", ":Lspsaga finder<CR>", { silent = true })
  keymap({"n"}, "<leader>a", ":Lspsaga code_action<CR>", { silent = true })
  keymap("v", "<leader>a", vim.lsp.buf.code_action, { silent = true })
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




-- Server to preconfigure. others are manually configured in lspconfig setup
-- local servers = {
--   'clangd',
--   'pyright',
--   'html',
--   'cssls',
--   "lua_ls",
--   "rust_analyzer",
--   "tsserver",
--   "bashls",
--   "astro",
--   --"marksman",
--   "tailwindcss",
--   "sqlls",
--   "jsonls"
-- }






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
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navbuddy",
      "jose-elias-alvarez/typescript.nvim",
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

      -- Set up language servers that are not installed by mason

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



      -- require("lspconfig").ltex.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities
      -- })


      -- require("lspconfig").grammarly.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   init_options = {clientId = "client_BaDkMgx4X19X9UxxYRCXZo"},
      -- })
      --
      --
      -- require("rust-tools").setup {
      --   tools = {
      --     inlay_hints = {
      --       auto = false
      --     }
      --   },
      --   server = {
      --     on_attach = on_attach,
      --     capabilities = capabilities
      --   },
      --   -- dap = { -- Enabling rust to use codelldb; This is related to the dap functions
      --   --   adapter = require('rust-tools.dap').get_codelldb_adapter(
      --   --     "codelldb",
      --   --     vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
      --   --   )
      --   -- }
      -- }


      require'lspconfig'.nushell.setup({
        cmd = {"/home/felix/coding/OpenSource/nushell/target/release/nu", "--lsp"}
      })


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
    opts = {
      -- registries = {
      --  -- "github:feel-ix-343/mason-registry"
      -- }
    }
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "mason.nvim",
    },
    -- event = "VeryLazy",
    lazy = true,

    config = function()
      require("mason-lspconfig").setup({
        -- ensure_installed = servers, -- Installs all servers in the list
        automatic_installation = false
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
            autostart = false
          }
        end,
        ["grammarly"] = function()
          require("lspconfig").grammarly.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            -- cmd = {"n", "run", "16", "/home/felix/.local/share/nvim/mason/bin/grammarly-languageserver", "--stdio"},
            init_options = {clientId = "client_BaDkMgx4X19X9UxxYRCXZo"},
          }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --   -- vim.g.rustaceanvim = {
        --   --   -- Plugin configuration
        --   --   tools = {
        --   --   },
        --   --   -- LSP configuration
        --   --   server = {
        --   --     on_attach = function(client, bufnr)
        --   --       on_attach(client, bufnr)
        --   --     end,
        --   --     settings = {
        --   --       -- rust-analyzer language server configuration
        --   --       ['rust-analyzer'] = {
        --   --       },
        --   --     },
        --   --   },
        --   --   -- DAP configuration
        --   --   dap = {
        --   --   },
        --   -- }
        --   require("rust-tools").setup {
        --     tools = {
        --       inlay_hints = {
        --         auto = false
        --       }
        --     },
        --     server = {
        --       on_attach = on_attach
        --     },
        --     -- dap = { -- Enabling rust to use codelldb; This is related to the dap functions
        --     --   adapter = require('rust-tools.dap').get_codelldb_adapter(
        --     --     "codelldb",
        --     --     vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
        --     --   )
        --     -- }
        --   }
        -- end,
        ["lua_ls"] = function()
          -- LUA
          -- Example custom server
          -- Make runtime files discoverable to the server

          require("lspconfig").lua_ls.setup {
            on_attach = on_attach,
            settings = {
              -- Lua = {
              --   completion = {
              --     callSnippet = "Replace"
              --   },
              --   workspace = {
              --     checkThirdParty = false
              --   }
              -- },
            },
          }
        end,
        ["yamlls"] = function()
          require("lspconfig").yamlls.setup {
            settings = {
              yaml = {
                schemaStore = {
                  -- You must disable built-in schemaStore support if you want to use
                  -- this plugin and its advanced options like `ignore`.
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
                schemas = require('schemastore').yaml.schemas(),
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
            filetypes = {"javascriptreact", "typescriptreact", "html", "astro"},
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
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = function ()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)

            vim.keymap.set(
              "n",
              "<leader>a",
              function()
                vim.cmd.RustLsp('codeAction')
              end
            )


            vim.keymap.set(
              "n",
              "<leader>rd",
              function()
                vim.cmd.RustLsp('renderDiagnostic')
              end
            )


            local autocmd_group = vim.api.nvim_create_augroup("AsyncSaveGroup", { clear = true })

            -- Run cargo fmt async on save
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = "*.*",
              group = autocmd_group,
              callback = function()
                -- Define the command to run asynchronously
                -- Use vim.loop.spawn to run the command asynchronously
                local handle
                handle = vim.loop.spawn("cargo", {
                  args = { "fmt" },
                  stdio = {nil, nil, nil},  -- No need to capture stdio
                }, function(code, signal)
                    -- This callback runs when the command completes
                    if code == 0 then
                      -- Command succeeded, now execute :wall
                      vim.schedule(function()
                        vim.cmd("e")
                      end)
                    else
                      -- Handle command failure if needed
                      print("cargo fmt failed with exit code " .. code)
                    end
                    -- Close the handle
                    handle:close()
                  end)
              end,
            })

          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              completion = {
                fullFunctionSignatures = {
                  enable = true
                }
              }
            },
          },
        },
        -- DAP configuration
        dap = {
        },
      }
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
