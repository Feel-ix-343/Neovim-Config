-- LSP Mappings
local lspconfig = require 'lspconfig'


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
  keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

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



-- local ig = require 'inlay-hints'
-- 
-- local on_attach = function (client, buffer)
--   on_attach(client, buffer)
--   ig.on_attach(client, buffer)
-- end


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'pyright', 'tsserver', 'html', 'cssls' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup({
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
    },
  },
})

-- rust
require("rust-tools").setup({
  tools = {
    auto = true,
  },
  server = {
    on_attach = on_attach
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
lspconfig.jdtls.setup{
  on_attach = on_attach,
  cmd = { 'jdtls' },
  root_dir = function(fname)
    return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
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
  Warn = " ",
  Hint  ="ﴞ",
  Info =  " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end









