local servers = { 'clangd', 'pyright', 'html', 'cssls', "sumneko_lua", "rust_analyzer", "tsserver", "bashls", "astro" }-- "hls" } -- the haskell installation is out of date; I have compiled it from source using ghcup

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
  --automatic_installation = true, -- I don't enable this beacuse I don't want it to auto install the haskell langauge server
})
-- Lint
local null_ls = require("null-ls")

null_ls.setup({
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

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
  automatic_setup = {
    exclude = {"clangd"}
  }
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
  -- keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })
  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
  keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
  keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

  keymap("i", "<C-K>", vim.lsp.buf.signature_help, { silent = true })
end



local lspconfigservers = { 'pyright', 'html', 'cssls', 'tsserver', 'hls', "astro", "bashls", "gopls", "tailwindcss" }
local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(lspconfigservers) do
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

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
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
