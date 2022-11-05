local servers = { 'clangd', 'pyright', 'html', 'cssls', "sumneko_lua", "rust_analyzer", "tsserver" }

local lsp_status = require('lsp-status')
lsp_status.register_progress()
lsp_status.config({
  status_symbol = "",
  indicator_errors = 'E',
  indicator_warnings = 'W',
  indicator_info = 'i',
  indicator_hint = '?',
  indicator_ok = 'Ok',
})

-- Mason
require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_installation = true
})

-- Lint
local null_ls = require("null-ls")
null_ls.setup()

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
  automatic_setup = true -- Sets up mason sources for null-ls
})
mason_null_ls.setup_handlers()

-- DAP
local dap = require'dap'
require("mason-nvim-dap").setup({
  automatic_installation = true,
  automatic_setup = true
})
require'mason-nvim-dap'.setup_handlers({
  function (source_name)
    -- all sources with no handler get passed here
    require('mason-nvim-dap.automatic_setup')(source_name)
  end,
  lldb = function(source_name)
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = 'codelldb',
        args = {"--port", "${port}" }
      }
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          print("Compiling Current File for Debug")
          print("File Name: " .. vim.fn.expand("%"))
          os.execute('g++ -g ' .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r") .. "DEBUG" )
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
      },
    }
  end
})


local on_attach = function(client, bufnr)
  local keymap = vim.keymap.set

  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  keymap("n", "gh", ":Lspsaga lsp_finder<CR>", { silent = true })

  -- Code action
  keymap("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", { silent = true })

  -- Rename
  keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

  -- Peek Definition
  -- you can edit the definition file in this flaotwindow
  -- also support open/vsplit/etc operation check definition_action_keys
  -- support tagstack C-t jump back
  keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

  -- Show line diagnostics
  keymap("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

  -- Show cursor diagnostic
  keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

  -- Diagnsotic jump can use `<c-o>` to jump back
  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

  -- Only jump to error
  keymap("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  keymap("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })

  -- Outline
  keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

  -- Hover Doc
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

  -- Float terminal
  keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
  -- if you want pass somc cli command into terminal you can do like this
  -- open lazygit in lspsaga float terminal
  -- keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
  -- close floaterm
  keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfigservers = { 'clangd', 'pyright', 'html', 'cssls', 'tsserver' }

local lspconfig = require('lspconfig')

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
  dap = {
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
local capabilities = vim.lsp.protocol.make_client_capabilities()
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- starting metals
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    on_attach()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- JAVA
-- Uses the jdtls-launcher
lspconfig.jdtls.setup {
  on_attach = on_attach,
  cmd = { 'jdtls' },
  root_dir = function(fname)
    return require 'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
  end
}

-- LUA
-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')


lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true
      }
    },
  },
}

-- LSP Icons
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



