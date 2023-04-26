local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


--require("PackerImports")
require("lazy").setup("plugin", {
  change_detection = {
    notify = false
  }
})

require("generalkeymaps")

--Set colorscheme
vim.o.termguicolors = true

-- require('github-theme')
-- vim.cmd.colorscheme "tokyonight-moon"
-- vim.cmd.colorscheme "nightfly"
-- vim.cmd.colorscheme "everforest"
-- vim.opt.background = "dark"
-- vim.cmd.colorscheme "oxocarbon"
-- vim.cmd.colorscheme "catppuccin"
-- vim.g.mellow_italic_functions = true
-- vim.g.mellow_bold_functions = true
-- vim.cmd [[colorscheme mellow]]
--vim.cmd [[let g:sonokai_style = 'maia']]
--vim.cmd [[colorscheme sonokai]]
vim.cmd("colorscheme kanagawa-dragon")
--vim.cmd("colorscheme nightfly")
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


-- Wrapping
vim.cmd[[set linebreak]]
vim.cmd[[set breakindentopt=list:-1]]


-- folds
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'
vim.o.foldnestmax = 99
-- Includes fold in the sign column
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- end


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




if vim.g.neovide then
  vim.opt.guifont = {"JetBrainsMono Nerd Font",":h8"}


  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  vim.cmd.colorscheme("catppuccin")

  vim.g.neovide_transparency = 0.8
  --vim.g.transparency = 0.8

  vim.g.neovide_floating_blur_amount_x = 5
  vim.g.neovide_floating_blur_amount_y = 5

  vim.cmd[[set winblend=70]]
  vim.cmd[[set pumblend=70]]

  vim.g.neovide_scroll_animation_length = 0.3


  vim.g.neovide_hide_mouse_when_typing = true
end
