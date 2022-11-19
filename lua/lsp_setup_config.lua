local servers = { 'clangd', 'pyright', 'html', 'cssls', "sumneko_lua", "rust_analyzer", "tsserver" }-- "hls" } -- the haskell installation is out of date; I have compiled it from source using ghcup

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
  --automatic_installation = true,
})

-- Lint
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns
  }
})

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
  automatic_setup = true -- Sets up mason sources for null-ls
})
mason_null_ls.setup_handlers()



local on_attach = function(client, bufnr)
  local keymap = vim.keymap.set
  keymap("n", "gh", ":Lspsaga lsp_finder<CR>", { silent = true })
  keymap("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
  keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
  keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
  keymap("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
  keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
  keymap("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  keymap("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
  keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
  keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end


local lspconfigservers = { 'clangd', 'pyright', 'html', 'cssls', 'tsserver', 'hls', "astro" }
local lspconfig = require('lspconfig')
for _, lsp in ipairs(lspconfigservers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
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



