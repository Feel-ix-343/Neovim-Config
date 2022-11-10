---@diagnostic disable: 113

local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- Package manager
	use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use { "williamboman/mason.nvim" }
  use 'williamboman/mason-lspconfig.nvim'
  use {
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
  }

	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			local treesitter = require'nvim-treesitter.configs'
			treesitter.setup {
				highlight = {
					enabled = true,
					additional_vim_regex_highlighting = true
				},
				indent = {
					enable = true
				}
			}
		end
	}

	-- Themes
	use 'folke/tokyonight.nvim'
	use {
		'catppuccin/nvim',
		as = "catppuccin",
	}
	use 'mhartington/oceanic-next'
	use 'frenzyexists/aquarium-vim'
	use 'pgdouyon/vim-yin-yang'
	use 'sainnhe/everforest'
	use 'luisiacc/gruvbox-baby'
	------------------------------------------------------

  use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
  use {
	  'nvim-lualine/lualine.nvim', -- Fancier statusline
	  config = function ()
		  require('lualine').setup {
			  options = {
				  icons_enabled = true,
				  theme = 'auto',
				  component_separators = { left = '', right = ''},
				  section_separators = { left = '', right = ''},
			  },
        sections = { lualine_c = { "require'lsp-status'.status()" } }
		  }
	  end
  }
use { 'nvim-lua/lsp-status.nvim' }

  use { 'hrsh7th/nvim-cmp', -- Autocompletion plugin
  config = function()
	  local cmp = require'cmp'

	  cmp.setup({
		  snippet = {
			  -- REQUIRED - you must specify a snippet engine
			  expand = function(args)
				  require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			  end,
		  },
		  window = {
			  completion = cmp.config.window.bordered(),
			  documentation = cmp.config.window.bordered(),
		  },
		  mapping = cmp.mapping.preset.insert({
			  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
			  ['<C-u>'] = cmp.mapping.scroll_docs(4),
			  ['<C-Space>'] = cmp.mapping.complete(),
			  --   ['<C-e>'] = cmp.mapping.abort(),
			  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		  }),
		  sources = cmp.config.sources({
			  { name = "nvim_lsp_signature_help"},
			  { name = 'nvim_lsp' },
			  { name = 'luasnip' }, -- For luasnip users.
			  { name = "path" },
		  }, {
			  -- { name = 'buffer' }, -- I don't like buffer completion
		  })
	  })

	  -- Set configuration for specific filetype.
	  cmp.setup.filetype('gitcommit', {
		  sources = cmp.config.sources({
			  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
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
  end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use({
	  "glepnir/lspsaga.nvim",
	  branch = "main",
	  config = function()
		  local saga = require("lspsaga")

		  saga.init_lsp_saga({
			  -- your configuration
			  -- Options with default value
			  -- "single" | "double" | "rounded" | "bold" | "plus"
			  border_style = "rounded",
			  --the range of 0 for fully opaque window (disabled) to 100 for fully
			  --transparent background. Values between 0-30 are typically most useful.
			  saga_winblend = 0,
			  -- when cursor in saga window you config these to move
			  move_in_saga = { prev = '<C-p>',next = '<C-n>'},
			  -- Error, Warn, Info, Hint
			  -- use emoji like
			  -- { "🙀", "😿", "😾", "😺" }
			  -- or
			  -- { "😡", "😥", "😤", "😐" }
			  -- and diagnostic_header can be a function type
			  -- must return a string and when diagnostic_header
			  -- is function type it will have a param `entry`
			  -- entry is a table type has these filed
			  -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
			  diagnostic_header = { " ", " ", " ", "ﴞ " },
			  -- preview lines of lsp_finder and definition preview
			  max_preview_lines = 10,
			  -- use emoji lightbulb in default
			  code_action_icon = "",
			  -- if true can press number to execute the codeaction in codeaction window
			  code_action_num_shortcut = true,
			  -- same as nvim-lightbulb but async
			  code_action_lightbulb = {
				  enable = true,
				  enable_in_insert = true,
				  cache_code_action = true,
				  sign = true,
				  update_time = 150,
				  sign_priority = 50,
				  virtual_text = true,
			  },
			  -- finder icons
			  finder_icons = {
				  def = '  ',
				  ref = '諭 ',
				  link = '  ',
			  },
			  -- finder do lsp request timeout
			  -- if your project big enough or your server very slow
			  -- you may need to increase this value
			  finder_request_timeout = 1500,
			  finder_action_keys = {
				  open = "o",
				  vsplit = "s",
				  split = "i",
				  tabe = "t",
				  quit = "q",
			  },
			  code_action_keys = {
				  quit = "q",
				  exec = "<CR>",
			  },
			  definition_action_keys = {
				  edit = '<C-c>o',
				  vsplit = '<C-c>v',
				  split = '<C-c>i',
				  tabe = '<C-c>t',
				  quit = 'q',
			  },
			  rename_action_quit = "<C-c>",
			  rename_in_select = true,
			  -- show symbols in winbar must nightly
			  -- in_custom mean use lspsaga api to get symbols
			  -- and set it to your custom winbar or some winbar plugins.
			  -- if in_cusomt = true you must set in_enable to false
			  symbol_in_winbar = {
				  in_custom = false,
				  enable = true,
				  separator = ' ',
				  show_file = true,
				  -- define how to customize filename, eg: %:., %
				  -- if not set, use default value `%:t`
				  -- more information see `vim.fn.expand` or `expand`
				  -- ## only valid after set `show_file = true`
				  file_formatter = "",
				  click_support = false,
			  },
			  -- show outline
			  show_outline = {
				  win_position = 'right',
				  --set special filetype win that outline window split.like NvimTree neotree
				  -- defx, db_ui
				  win_with = '',
				  win_width = 30,
				  auto_enter = true,
				  auto_preview = true,
				  virt_text = '┃',
				  jump_key = 'o',
				  -- auto refresh when change buffer
				  auto_refresh = true,
			  },
			  -- custom lsp kind
			  -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
			  custom_kind = {},
			  -- if you don't use nvim-lspconfig you must pass your server name and
			  -- the related filetypes into this table
			  -- like server_filetype_map = { metals = { "sbt", "scala" } }
			  server_filetype_map = {},
		  })

		  -- COMMANDS ARE LOCATED IN THE LSPCONFIG ONATTACH FUNCTION

	  end,
  })

  use {
	  'kyazdani42/nvim-tree.lua',
	  config = function ()
		  require('nvim-tree').setup()
	  end,
	  requires = {
		  'kyazdani42/nvim-web-devicons', -- optional, for file icon
	  }
  }

  use {
	  'romgrk/barbar.nvim',
	  config = function ()
		  local map = vim.api.nvim_set_keymap
		  local opts = { noremap = true, silent = true }

		  -- Move to previous/next
		  map('n', 'H', ':BufferPrevious<CR>', opts)
		  map('n', 'L', ':BufferNext<CR>', opts)
		  -- Re-order to previous/next
		  map('n', '<leader>H', ':BufferMovePrevious<CR>', opts)
		  map('n', '<leader>L', ' :BufferMoveNext<CR>', opts)
		  -- Goto buffer in position...
		  map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
		  map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
		  map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
		  map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
		  map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
		  map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
		  map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
		  map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
		  map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
		  map('n', '<A-0>', ':BufferLast<CR>', opts)
		  -- Close buffer
		  map('n', '<leader>c', ':BufferClose<CR>', opts)
		  -- Wipeout buffer
		  --                 :BufferWipeout<CR>
		  -- Close commands
		  --                 :BufferCloseAllButCurrent<CR>
		  --                 :BufferCloseBuffersLeft<CR>
		  --                 :BufferCloseBuffersRight<CR>
		  -- Magic buffer-picking mode
		  map('n', '<C-p>', ':BufferPick<CR>', opts)
		  -- Sort automatically by...
		  map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
		  map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
		  map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)
	  end,
	  requires = {'kyazdani42/nvim-web-devicons'}
  }

  use {
	  'nvim-telescope/telescope.nvim',
	  config = function ()
      require('telescope').setup({})
		  vim.keymap.set("n", "<leader>tr", require('telescope.builtin').lsp_references, {noremap = true})
		  vim.keymap.set("n", "<leader>ts", require('telescope.builtin').grep_string, {noremap = true})
		  vim.keymap.set("n", "<leader>tf", require("telescope.builtin").find_files, {noremap = true})
		  vim.keymap.set("n", "<leader>tk", require("telescope.builtin").keymaps, {noremap=true})
	  end,
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})

  use {
	  'windwp/nvim-autopairs',
	  config = function()
		  require('nvim-autopairs').setup()
	  end
  }

  use { "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
	  require("todo-comments").setup {
		  search = {
			  command = "rg",
			  args = {
				  "--color=never",
				  "--no-heading",
				  "--with-filename",
				  "--line-number",
				  "--column",
				  "--glob=!node_modules",
			  },
			  pattern = [[\b(KEYWORDS):]],
		  },
	  }
  end
}

use 'tpope/vim-obsession'

use {
	'karb94/neoscroll.nvim',
	config = function ()
		require('neoscroll').setup()
	end
}

use 'simrat39/rust-tools.nvim'
use 'tpope/vim-fugitive'

-- Lua
use {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	end
}

use "jayp0521/mason-nvim-dap.nvim"

use { 'mfussenegger/nvim-dap', config = function ()
  -- Key Commands
	vim.cmd[[
	nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
	nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
	nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
	nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
	nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
	nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
	nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
	nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
	]]

end}
use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}, config = function ()
  vim.keymap.set('n', "<leader>do", require('dapui').open, {} )
  vim.keymap.set('n', "<leader>dc", require('dapui').close, {} )
	require("dapui").setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		-- Expand lines larger than the window
		-- Requires >= 0.7
		expand_lines = vim.fn.has("nvim-0.7"),
		-- Layouts define sections of the screen to place windows.
		-- The position can be "left", "right", "top" or "bottom".
		-- The size specifies the height/width depending on position. It can be an Int
		-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
		-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
		-- Elements are the elements shown in the layout (in order).
		-- Layouts are opened in order so that earlier layouts take priority in window sizing.
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40, -- 40 columns
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "single", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil, -- Can be integer or nil.
			max_value_lines = 100, -- Can be integer or nil.
		}
	})
  

end }

-- use { 'simrat39/inlay-hints.nvim',
--   config = function()
	--     require("inlay-hints").setup({
		--       -- only_current_line = true
		--     })
		--   end
		-- }

		-- install without yarn or npm
		use({
			"iamcco/markdown-preview.nvim",
			run = function() vim.fn["mkdp#util#install"]() end,
		})

    use 'nvim-treesitter/playground'
    use {
      'nvim-treesitter/nvim-treesitter-context',
      config = function ()
        require'treesitter-context'.setup{
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
          trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
          },
          -- Patterns for specific filetypes
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
          },
          rust = {
            'impl_item',
            'struct',
            'enum',
          },
          scala = {
            'object_definition',
          },
          vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
          },
          markdown = {
            'section',
          },
          elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
          },
          json = {
            'pair',
          },
          yaml = {
            'block_mapping_pair',
          },
        },
        exact_patterns = {
          -- Example for a specific filetype with Lua patterns
          -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
          -- exactly match "impl_item" only)
          -- rust = true,
        },

        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        zindex = 20, -- The Z-index of the context window
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
      }
    end
  }

end)
