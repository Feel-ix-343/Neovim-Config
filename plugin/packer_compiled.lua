-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/felix/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/felix/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/felix/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/felix/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/felix/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["aquarium-vim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/aquarium-vim",
    url = "https://github.com/frenzyexists/aquarium-vim"
  },
  ["barbar.nvim"] = {
    config = { "\27LJ\2\nç\b\0\0\b\0+\0w6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\21\0'\6\22\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\23\0'\6\24\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\25\0'\6\26\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\27\0'\6\28\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\29\0'\6\30\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\31\0'\6 \0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5!\0'\6\"\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5#\0'\6$\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5%\0'\6&\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5'\0'\6(\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5)\0'\6*\0\18\a\1\0B\2\5\1K\0\1\0\31:BufferOrderByLanguage<CR>\14<Space>bl :BufferOrderByDirectory<CR>\14<Space>bd#:BufferOrderByBufferNumber<CR>\14<Space>bb\20:BufferPick<CR>\n<C-p>\21:BufferClose<CR>\14<leader>c\20:BufferLast<CR>\n<A-0>\22:BufferGoto 9<CR>\n<A-9>\22:BufferGoto 8<CR>\n<A-8>\22:BufferGoto 7<CR>\n<A-7>\22:BufferGoto 6<CR>\n<A-6>\22:BufferGoto 5<CR>\n<A-5>\22:BufferGoto 4<CR>\n<A-4>\22:BufferGoto 3<CR>\n<A-3>\22:BufferGoto 2<CR>\n<A-2>\22:BufferGoto 1<CR>\n<A-1>\25 :BufferMoveNext<CR>\14<leader>L\28:BufferMovePrevious<CR>\14<leader>H\20:BufferNext<CR>\6L\24:BufferPrevious<CR>\6H\6n\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  catppuccin = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\n∫\1\0\0\6\0\v\0\0206\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\6\0'\5\a\0B\1\4\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\b\0'\5\t\0B\1\4\0019\1\n\0B\1\1\1K\0\1\0\nsetup\23:DiffviewClose<CR>\15<leader>gc\22:DiffviewOpen<CR>\15<leader>go\6n\bset\vkeymap\bvim\rdiffview\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  everforest = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox-baby"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/gruvbox-baby",
    url = "https://github.com/luisiacc/gruvbox-baby"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_lines.nvim"] = {
    config = { "\27LJ\2\nr\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0B\0\2\1K\0\1\0\1\0\1\17virtual_text\1\vconfig\15diagnostic\bvim\nsetup\14lsp_lines\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nú\b\0\0\a\0\25\0!6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0036\4\0\0'\6\22\0B\4\2\0029\4\23\4B\4\1\2=\4\23\0034\4\0\0=\4\24\3B\1\2\1K\0\1\0\24server_filetype_map\16custom_kind,catppuccin.groups.integrations.lsp_saga\17show_outline\1\0\b\17auto_refresh\2\14virt_text\b‚îÉ\17auto_preview\2\15auto_enter\2\14win_width\3\30\rwin_with\5\17win_position\nright\rjump_key\6o\21symbol_in_winbar\1\0\5\18click_support\1\19file_formatter\5\14show_file\2\14separator\tÔëä \venable\1\27definition_action_keys\1\0\5\vvsplit\v<C-c>v\nsplit\v<C-c>i\tquit\6q\tedit\v<C-c>o\ttabe\v<C-c>t\21code_action_keys\1\0\2\tquit\6q\texec\t<CR>\23finder_action_keys\1\0\5\vvsplit\6s\nsplit\6i\topen\6o\tquit\6q\ttabe\6t\17finder_icons\1\0\3\tlink\nÔ†∏  \bref\tÔ™æ \bdef\nÓàï  \26code_action_lightbulb\1\0\a\venable\2\17virtual_text\2\16update_time\3ñ\1\tsign\2\22cache_code_action\2\21enable_in_insert\2\18sign_priority\0032\22diagnostic_header\1\5\0\0\tÔÅó \tÔÅ™ \tÔÅö \tÔ¥û \17move_in_saga\1\0\2\tprev\n<C-p>\tnext\n<C-n>\1\0\b\17border_style\frounded\18saga_winblend\3\0\21rename_in_select\2\23rename_action_quit\n<C-c>\27finder_request_timeout\3‹\v\29code_action_num_shortcut\2\21code_action_icon\bÔÉ´\22max_preview_lines\3\n\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nö\2\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\rsections\14lualine_c\1\0\0\1\2\0\0!require'lsp-status'.status()\foptions\1\0\0\23section_separators\1\0\2\nright\bÓÇ≤\tleft\bÓÇ∞\25component_separators\1\0\2\nright\bÓÇ≥\tleft\bÓÇ±\1\0\2\18icons_enabled\2\ntheme\15catppuccin\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-null-ls.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/mason-null-ls.nvim",
    url = "https://github.com/jayp0521/mason-null-ls.nvim"
  },
  ["mason-nvim-dap.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/mason-nvim-dap.nvim",
    url = "https://github.com/jayp0521/mason-nvim-dap.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire¸\6\1\0\n\0-\0u6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0035\4\v\0009\5\b\0009\5\t\0059\5\n\5B\5\1\2=\5\f\0049\5\b\0009\5\t\0059\5\n\5B\5\1\2=\5\r\4=\4\t\0039\4\14\0009\4\15\0049\4\16\0045\6\18\0009\a\14\0009\a\17\a)\t¸ˇB\a\2\2=\a\19\0069\a\14\0009\a\17\a)\t\4\0B\a\2\2=\a\20\0069\a\14\0009\a\21\aB\a\1\2=\a\22\0069\a\14\0009\a\23\a5\t\24\0B\a\2\2=\a\25\6B\4\2\2=\4\14\0039\4\b\0009\4\26\0044\6\5\0005\a\27\0>\a\1\0065\a\28\0>\a\2\0065\a\29\0>\a\3\0065\a\30\0>\a\4\0064\a\0\0B\4\3\2=\4\26\3B\1\2\0019\1\2\0009\1\31\1'\3 \0005\4#\0009\5\b\0009\5\26\0054\a\3\0005\b!\0>\b\1\a4\b\3\0005\t\"\0>\t\1\bB\5\3\2=\5\26\4B\1\3\0019\1\2\0009\1$\1'\3%\0005\4&\0009\5\14\0009\5\15\0059\5$\5B\5\1\2=\5\14\0049\5\b\0009\5\26\0054\a\3\0005\b'\0>\b\1\a4\b\3\0005\t(\0>\t\1\bB\5\3\2=\5\26\4B\1\3\0019\1\2\0009\1$\1'\3)\0005\4*\0009\5\14\0009\5\15\0059\5$\5B\5\1\2=\5\14\0049\5\b\0009\5\26\0054\a\3\0005\b+\0>\b\1\a4\b\3\0005\t,\0>\t\1\bB\5\3\2=\5\26\4B\1\3\1K\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\1\tname\29nvim_lsp_document_symbol\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\1\0\1\tname\tpath\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\1\0\1\tname\28nvim_lsp_signature_help\fsources\t<CR>\1\0\1\vselect\2\fconfirm\14<C-Space>\rcomplete\n<C-u>\n<C-d>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\18documentation\15completion\1\0\0\rbordered\vwindow\vconfig\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\nﬂ\4\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ø\4\tnnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>\n\tnnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>\n\tnnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>\n\tnnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>\n\tnnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>\n\tnnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>\n\tnnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>\n\tnnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>\n\t\bcmd\bvim\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n€\5\0\0\a\0%\0?6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\0044\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\5\0'\6\6\0B\4\2\0029\4\t\0044\5\0\0B\0\5\0016\0\5\0'\2\6\0B\0\2\0029\0\n\0005\2\f\0005\3\v\0=\3\r\0025\3\15\0005\4\14\0=\4\16\3=\3\17\0026\3\0\0009\3\18\0039\3\19\3'\5\20\0B\3\2\2=\3\21\0024\3\3\0005\4\24\0005\5\23\0005\6\22\0>\6\1\5=\5\25\4>\4\1\0035\4\27\0005\5\26\0=\5\25\4>\4\2\3=\3\28\0025\3\29\0005\4\31\0005\5\30\0=\5\t\4=\4\17\3=\3 \0025\3!\0=\3\"\0025\3#\0=\3$\2B\0\2\1K\0\1\0\vrender\1\0\1\20max_value_lines\3d\fwindows\1\0\1\vindent\3\1\rfloating\1\0\0\1\3\0\0\6q\n<Esc>\1\0\1\vborder\vsingle\flayouts\1\0\2\rposition\vbottom\tsize\4\0ÄÄ¿˛\3\1\3\0\0\trepl\fconsole\relements\1\0\2\rposition\tleft\tsize\3(\1\5\0\0\0\16breakpoints\vstacks\fwatches\1\0\2\tsize\4\0ÄÄ¿˛\3\aid\vscopes\17expand_lines\rnvim-0.7\bhas\afn\rmappings\vexpand\1\0\5\vremove\6d\topen\6o\trepl\6r\vtoggle\6t\tedit\6e\1\3\0\0\t<CR>\18<2-LeftMouse>\nicons\1\0\0\1\0\3\18current_frame\b‚ñ∏\14collapsed\b‚ñ∏\rexpanded\b‚ñæ\nsetup\nclose\15<leader>dc\topen\ndapui\frequire\15<leader>do\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-metals"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-metals",
    url = "https://github.com/scalameta/nvim-metals"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nª\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3B\1\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\n–\5\0\0\5\0\28\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0024\3\0\0=\3\24\2B\0\2\0016\0\25\0009\0\26\0'\2\27\0B\0\2\1K\0\1\0009hi TreesitterContextBottom gui=underline guisp=black\bcmd\bvim\19exact_patterns\rpatterns\tyaml\1\2\0\0\23block_mapping_pair\tjson\1\2\0\0\tpair\velixir\1\t\0\0\23anonymous_function\14arguments\nblock\rdo_block\tlist\bmap\ntuple\19quoted_content\rmarkdown\1\2\0\0\fsection\tvhdl\1\4\0\0\22process_statement\22architecture_body\23entity_declaration\nscala\1\2\0\0\22object_definition\trust\1\4\0\0\14impl_item\vstruct\tenum\btex\1\5\0\0\fchapter\fsection\15subsection\18subsubsection\fdefault\1\0\0\1\t\0\0\nclass\rfunction\vmethod\bfor\nwhile\aif\vswitch\tcase\1\0\6\tmode\vcursor\vzindex\3\20\22min_window_height\3\0\venable\2\15trim_scope\nouter\14max_lines\3\0\nsetup\23treesitter-context\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/oceanic-next",
    url = "https://github.com/mhartington/oceanic-next"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/mjlbach/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nò\3\0\0\a\0\20\00036\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\0\0'\6\b\0B\4\2\0029\4\t\0045\5\n\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\v\0006\4\0\0'\6\b\0B\4\2\0029\4\f\0045\5\r\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\14\0006\4\0\0'\6\b\0B\4\2\0029\4\15\0045\5\16\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\17\0006\4\0\0'\6\b\0B\4\2\0029\4\18\0045\5\19\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\fkeymaps\15<leader>tk\1\0\1\fnoremap\2\15find_files\15<leader>tf\1\0\1\fnoremap\2\16grep_string\15<leader>ts\1\0\1\fnoremap\2\19lsp_references\22telescope.builtin\15<leader>tr\6n\bset\vkeymap\bvim\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n›\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vsearch\1\0\0\targs\1\a\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\25--glob=!node_modules\1\0\2\fpattern\18\\b(KEYWORDS):\fcommand\arg\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/vim-obsession",
    url = "https://github.com/tpope/vim-obsession"
  },
  ["vim-yin-yang"] = {
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/vim-yin-yang",
    url = "https://github.com/pgdouyon/vim-yin-yang"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/felix/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\n∫\1\0\0\6\0\v\0\0206\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\6\0'\5\a\0B\1\4\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\b\0'\5\t\0B\1\4\0019\1\n\0B\1\1\1K\0\1\0\nsetup\23:DiffviewClose<CR>\15<leader>gc\22:DiffviewOpen<CR>\15<leader>go\6n\bset\vkeymap\bvim\rdiffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nª\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3B\1\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\n–\5\0\0\5\0\28\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0024\3\0\0=\3\24\2B\0\2\0016\0\25\0009\0\26\0'\2\27\0B\0\2\1K\0\1\0009hi TreesitterContextBottom gui=underline guisp=black\bcmd\bvim\19exact_patterns\rpatterns\tyaml\1\2\0\0\23block_mapping_pair\tjson\1\2\0\0\tpair\velixir\1\t\0\0\23anonymous_function\14arguments\nblock\rdo_block\tlist\bmap\ntuple\19quoted_content\rmarkdown\1\2\0\0\fsection\tvhdl\1\4\0\0\22process_statement\22architecture_body\23entity_declaration\nscala\1\2\0\0\22object_definition\trust\1\4\0\0\14impl_item\vstruct\tenum\btex\1\5\0\0\fchapter\fsection\15subsection\18subsubsection\fdefault\1\0\0\1\t\0\0\nclass\rfunction\vmethod\bfor\nwhile\aif\vswitch\tcase\1\0\6\tmode\vcursor\vzindex\3\20\22min_window_height\3\0\venable\2\15trim_scope\nouter\14max_lines\3\0\nsetup\23treesitter-context\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: lsp_lines.nvim
time([[Config for lsp_lines.nvim]], true)
try_loadstring("\27LJ\2\nr\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0005\2\6\0B\0\2\1K\0\1\0\1\0\1\17virtual_text\1\vconfig\15diagnostic\bvim\nsetup\14lsp_lines\frequire\0", "config", "lsp_lines.nvim")
time([[Config for lsp_lines.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nú\b\0\0\a\0\25\0!6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0036\4\0\0'\6\22\0B\4\2\0029\4\23\4B\4\1\2=\4\23\0034\4\0\0=\4\24\3B\1\2\1K\0\1\0\24server_filetype_map\16custom_kind,catppuccin.groups.integrations.lsp_saga\17show_outline\1\0\b\17auto_refresh\2\14virt_text\b‚îÉ\17auto_preview\2\15auto_enter\2\14win_width\3\30\rwin_with\5\17win_position\nright\rjump_key\6o\21symbol_in_winbar\1\0\5\18click_support\1\19file_formatter\5\14show_file\2\14separator\tÔëä \venable\1\27definition_action_keys\1\0\5\vvsplit\v<C-c>v\nsplit\v<C-c>i\tquit\6q\tedit\v<C-c>o\ttabe\v<C-c>t\21code_action_keys\1\0\2\tquit\6q\texec\t<CR>\23finder_action_keys\1\0\5\vvsplit\6s\nsplit\6i\topen\6o\tquit\6q\ttabe\6t\17finder_icons\1\0\3\tlink\nÔ†∏  \bref\tÔ™æ \bdef\nÓàï  \26code_action_lightbulb\1\0\a\venable\2\17virtual_text\2\16update_time\3ñ\1\tsign\2\22cache_code_action\2\21enable_in_insert\2\18sign_priority\0032\22diagnostic_header\1\5\0\0\tÔÅó \tÔÅ™ \tÔÅö \tÔ¥û \17move_in_saga\1\0\2\tprev\n<C-p>\tnext\n<C-n>\1\0\b\17border_style\frounded\18saga_winblend\3\0\21rename_in_select\2\23rename_action_quit\n<C-c>\27finder_request_timeout\3‹\v\29code_action_num_shortcut\2\21code_action_icon\bÔÉ´\22max_preview_lines\3\n\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: barbar.nvim
time([[Config for barbar.nvim]], true)
try_loadstring("\27LJ\2\nç\b\0\0\b\0+\0w6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\21\0'\6\22\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\23\0'\6\24\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\25\0'\6\26\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\27\0'\6\28\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\29\0'\6\30\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\31\0'\6 \0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5!\0'\6\"\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5#\0'\6$\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5%\0'\6&\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5'\0'\6(\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5)\0'\6*\0\18\a\1\0B\2\5\1K\0\1\0\31:BufferOrderByLanguage<CR>\14<Space>bl :BufferOrderByDirectory<CR>\14<Space>bd#:BufferOrderByBufferNumber<CR>\14<Space>bb\20:BufferPick<CR>\n<C-p>\21:BufferClose<CR>\14<leader>c\20:BufferLast<CR>\n<A-0>\22:BufferGoto 9<CR>\n<A-9>\22:BufferGoto 8<CR>\n<A-8>\22:BufferGoto 7<CR>\n<A-7>\22:BufferGoto 6<CR>\n<A-6>\22:BufferGoto 5<CR>\n<A-5>\22:BufferGoto 4<CR>\n<A-4>\22:BufferGoto 3<CR>\n<A-3>\22:BufferGoto 2<CR>\n<A-2>\22:BufferGoto 1<CR>\n<A-1>\25 :BufferMoveNext<CR>\14<leader>L\28:BufferMovePrevious<CR>\14<leader>H\20:BufferNext<CR>\6L\24:BufferPrevious<CR>\6H\6n\1\0\2\fnoremap\2\vsilent\2\20nvim_set_keymap\bapi\bvim\0", "config", "barbar.nvim")
time([[Config for barbar.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nö\2\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\v\0005\4\n\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\rsections\14lualine_c\1\0\0\1\2\0\0!require'lsp-status'.status()\foptions\1\0\0\23section_separators\1\0\2\nright\bÓÇ≤\tleft\bÓÇ∞\25component_separators\1\0\2\nright\bÓÇ≥\tleft\bÓÇ±\1\0\2\18icons_enabled\2\ntheme\15catppuccin\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire¸\6\1\0\n\0-\0u6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0035\4\v\0009\5\b\0009\5\t\0059\5\n\5B\5\1\2=\5\f\0049\5\b\0009\5\t\0059\5\n\5B\5\1\2=\5\r\4=\4\t\0039\4\14\0009\4\15\0049\4\16\0045\6\18\0009\a\14\0009\a\17\a)\t¸ˇB\a\2\2=\a\19\0069\a\14\0009\a\17\a)\t\4\0B\a\2\2=\a\20\0069\a\14\0009\a\21\aB\a\1\2=\a\22\0069\a\14\0009\a\23\a5\t\24\0B\a\2\2=\a\25\6B\4\2\2=\4\14\0039\4\b\0009\4\26\0044\6\5\0005\a\27\0>\a\1\0065\a\28\0>\a\2\0065\a\29\0>\a\3\0065\a\30\0>\a\4\0064\a\0\0B\4\3\2=\4\26\3B\1\2\0019\1\2\0009\1\31\1'\3 \0005\4#\0009\5\b\0009\5\26\0054\a\3\0005\b!\0>\b\1\a4\b\3\0005\t\"\0>\t\1\bB\5\3\2=\5\26\4B\1\3\0019\1\2\0009\1$\1'\3%\0005\4&\0009\5\14\0009\5\15\0059\5$\5B\5\1\2=\5\14\0049\5\b\0009\5\26\0054\a\3\0005\b'\0>\b\1\a4\b\3\0005\t(\0>\t\1\bB\5\3\2=\5\26\4B\1\3\0019\1\2\0009\1$\1'\3)\0005\4*\0009\5\14\0009\5\15\0059\5$\5B\5\1\2=\5\14\0049\5\b\0009\5\26\0054\a\3\0005\b+\0>\b\1\a4\b\3\0005\t,\0>\t\1\bB\5\3\2=\5\26\4B\1\3\1K\0\1\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\1\tname\29nvim_lsp_document_symbol\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\1\0\1\tname\tpath\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\1\0\1\tname\28nvim_lsp_signature_help\fsources\t<CR>\1\0\1\vselect\2\fconfirm\14<C-Space>\rcomplete\n<C-u>\n<C-d>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\18documentation\15completion\1\0\0\rbordered\vwindow\vconfig\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nò\3\0\0\a\0\20\00036\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\0\0'\6\b\0B\4\2\0029\4\t\0045\5\n\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\v\0006\4\0\0'\6\b\0B\4\2\0029\4\f\0045\5\r\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\14\0006\4\0\0'\6\b\0B\4\2\0029\4\15\0045\5\16\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\17\0006\4\0\0'\6\b\0B\4\2\0029\4\18\0045\5\19\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\fkeymaps\15<leader>tk\1\0\1\fnoremap\2\15find_files\15<leader>tf\1\0\1\fnoremap\2\16grep_string\15<leader>ts\1\0\1\fnoremap\2\19lsp_references\22telescope.builtin\15<leader>tr\6n\bset\vkeymap\bvim\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\nﬂ\4\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0ø\4\tnnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>\n\tnnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>\n\tnnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>\n\tnnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>\n\tnnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>\n\tnnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>\n\tnnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>\n\tnnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>\n\t\bcmd\bvim\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n›\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\vsearch\1\0\0\targs\1\a\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\25--glob=!node_modules\1\0\2\fpattern\18\\b(KEYWORDS):\fcommand\arg\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
try_loadstring("\27LJ\2\n€\5\0\0\a\0%\0?6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0006\4\5\0'\6\6\0B\4\2\0029\4\a\0044\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\b\0006\4\5\0'\6\6\0B\4\2\0029\4\t\0044\5\0\0B\0\5\0016\0\5\0'\2\6\0B\0\2\0029\0\n\0005\2\f\0005\3\v\0=\3\r\0025\3\15\0005\4\14\0=\4\16\3=\3\17\0026\3\0\0009\3\18\0039\3\19\3'\5\20\0B\3\2\2=\3\21\0024\3\3\0005\4\24\0005\5\23\0005\6\22\0>\6\1\5=\5\25\4>\4\1\0035\4\27\0005\5\26\0=\5\25\4>\4\2\3=\3\28\0025\3\29\0005\4\31\0005\5\30\0=\5\t\4=\4\17\3=\3 \0025\3!\0=\3\"\0025\3#\0=\3$\2B\0\2\1K\0\1\0\vrender\1\0\1\20max_value_lines\3d\fwindows\1\0\1\vindent\3\1\rfloating\1\0\0\1\3\0\0\6q\n<Esc>\1\0\1\vborder\vsingle\flayouts\1\0\2\rposition\vbottom\tsize\4\0ÄÄ¿˛\3\1\3\0\0\trepl\fconsole\relements\1\0\2\rposition\tleft\tsize\3(\1\5\0\0\0\16breakpoints\vstacks\fwatches\1\0\2\tsize\4\0ÄÄ¿˛\3\aid\vscopes\17expand_lines\rnvim-0.7\bhas\afn\rmappings\vexpand\1\0\5\vremove\6d\topen\6o\trepl\6r\vtoggle\6t\tedit\6e\1\3\0\0\t<CR>\18<2-LeftMouse>\nicons\1\0\0\1\0\3\18current_frame\b‚ñ∏\14collapsed\b‚ñ∏\rexpanded\b‚ñæ\nsetup\nclose\15<leader>dc\topen\ndapui\frequire\15<leader>do\6n\bset\vkeymap\bvim\0", "config", "nvim-dap-ui")
time([[Config for nvim-dap-ui]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
