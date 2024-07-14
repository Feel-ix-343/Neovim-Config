return {
  'saecki/crates.nvim',
  tag = 'stable',
  config = function()
    require('crates').setup({
      lsp = {
        enabled = true,
        -- on_attach = function(client, bufnr) -- this is in the lspsetup file
        --   require("plugin/LspSetup"):LSPOnAttach(client, bufnr)
        -- end,
        actions = true,
        completion = true,
        hover = true,
      },
    })
  end,
}
