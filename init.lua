--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("PackerImports")


--Set colorscheme
vim.o.termguicolors = true


-- require('github-theme')
-- vim.cmd.colorscheme "tokyonight-moon"
-- vim.cmd.colorscheme "nightfly"
-- vim.opt.background = "dark"
vim.cmd.colorscheme "oxocarbon"
-- vim.cmd.colorscheme "catppuccin"
-- vim.g.mellow_italic_functions = true
-- vim.g.mellow_bold_functions = true
-- vim.cmd [[colorscheme mellow]]
-- colorscheme end

--highlighting ;; Making background colors transparent
vim.cmd[[
  highlight NormalFloat guibg=none
  highlight LspFloatWinNormal guibg=none
  highlight BufferInactive guibg=none
  highlight BufferInactiveSign guibg=none
  highlight BufferInactiveMod guibg=none
  highlight BufferInactiveIndex guibg=none
  highlight BufferVisible guibg=none
  highlight BufferVisibleSign guibg=none
  highlight BufferVisibleMod guibg=none
  highlight BufferVisibleIndex guibg=none
  highlight BufferVisibleTarget guibg=none
  highlight BufferInactiveTarget guibg=none
  highlight BufferTabpage guibg=none
  highlight BufferTabpages guibg=none
  highlight CursorColumn guibg=none
]]
--highlighting end


-- Main keymappings
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {noremap=true})

vim.api.nvim_set_keymap('n', '<leader><leader>',':w<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', {noremap=true})

vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', {noremap=true}) --mapping backspace to delete the whole word

vim.api.nvim_set_keymap("n", "<leader>ps", ":PackerSync<CR>", {noremap=true})
vim.keymap.set("n", "<leader>s", ":source %<CR>", {nowait=true, noremap=true})
-- keymappings end


vim.cmd[[
  set foldlevel=99
]]

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.clipboard = 'unnamedplus' -- Setting the clip board to the regular copy/paste one
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.termguicolors = true
vim.opt.scrolloff = 6

--Set highlight on search
vim.o.hlsearch = false
--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'


-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.cmd [[autocmd FileType * set formatoptions-=cro]]





