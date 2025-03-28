return {
  'hrsh7th/nvim-cmp',
  event = {"InsertEnter", "CmdlineEnter"},
  dependencies = {
    {'hrsh7th/cmp-nvim-lsp', event = "InsertEnter"},
    {'hrsh7th/cmp-buffer', event = "InsertEnter"},
    {'hrsh7th/cmp-path', event = "InsertEnter"},
    {'hrsh7th/cmp-cmdline', event = "CmdlineEnter"},
    {'saadparwaiz1/cmp_luasnip', event = "InsertEnter"},
    {'L3MON4D3/LuaSnip', event = "InsertEnter", build="make install_jsregexp"},
    {'onsails/lspkind.nvim', event = "InsertEnter"},
    {"lukas-reineke/cmp-rg", event = "InsertEnter"},
    {"kdheepak/cmp-latex-symbols", ft = {"tex", "latex", "markdown"}},
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require('luasnip').lsp_expand(args.body, {indent = false}) -- For `luasnip` users.
        end,
      },
      performance = {
        max_view_entries = 50,
      },
      formatting = {
        fields = {"kind", "abbr", "menu"},
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          show_labelDetails = false,
          symbol_map = {
            Copilot = " ",
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          },
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first),

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function (entry, item)
            if vim.bo.filetype == "rust" then
              item.menu = ""
            end
            return item
          end
        })
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        --   ['<C-e>'] = cmp.mapping.abort(),
        ['<C-l>'] = cmp.mapping.confirm({
          select = false,
          behavior = cmp.ConfirmBehavior.Replace,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {  "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "copilot" },
        { name = "path" },
        { name = "lazydev", group_index = 0, condition = function() return vim.bo.filetype == "lua" end },
      }),
      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
        },
      },
      completion = {
        keyword_length = 1,
        throttle_time = 80,
      },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },  -- You can specify the `cmp_git` source if you have installed it.
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
      }, {
          { name = 'buffer' },
        })
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
          { name = 'cmdline' }
        })
    })



    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources({
        {
          name = "latex_symbols",
          option = {
            strategy = 1, -- mixed
          },
        },
        {
          name = 'nvim_lsp',
          option = {
            markdown_oxide = {
              keyword_pattern = [[\(\k\| \|\/\|#\|\^\)\+]]
            }
          }
        },
        { name = 'luasnip' }, -- For luasnip users.
        { name = "path" },
      })
    })
  end
}

