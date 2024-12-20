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

-- Copy current file path relative to git root to clipboard
vim.api.nvim_set_keymap('n', '<leader>y', [[<cmd>lua vim.fn.setreg('+', vim.fn.trim(vim.fn.system('git ls-files --full-name ' .. vim.fn.expand('%:p'))))<CR>]], { noremap = true, silent = true })

-- import environment variabels
require("envs")


--require("PackerImports")
require("lazy").setup("plugin", {
  change_detection = {
    notify = false,
  }
})

require("generalkeymaps")
require("colorscheme")

--Set colorscheme
vim.o.termguicolors = true


vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- end


vim.opt.clipboard = 'unnamedplus' -- Setting the clip board to the regular copy/paste one
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
-- vim.opt.cursorline = true -- highlight the current line
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.termguicolors = true
vim.opt.scrolloff = 10

--Set highlight on search
vim.o.hlsearch = false
--Make line numbers default
vim.wo.number = true

vim.opt.wrap = false

--Enable mouse mode
--vim.o.mouse = 'a'

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

vim.o.cmdheight = 2



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
  vim.opt.guifont = {"JetBrainsMono Nerd Font",":h13"}
  --vim.opt.guifont = {"IntelOne Mono",":h14"}

  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  vim.cmd.colorscheme("everforest")

  vim.g.neovide_refresh_rate = 60

  -- -- Helper function for transparency formatting
  -- local alpha = function()
  --   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  -- end
  -- -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- vim.g.neovide_transparency = .9
  -- vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = "#8BA4B0" .. alpha()

  vim.g.neovide_floating_blur_amount_x = 4
  vim.g.neovide_floating_blur_amount_y = 4

  vim.cmd[[set winblend=40]]
  vim.cmd[[set pumblend=40]]

  vim.g.neovide_scroll_animation_length = .3
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = .3
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_lifetime = 2


  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovim_confirm_quit = false
end

--vim.cmd[[autocmd BufWrite * execute "mksession!"]]

vim.cmd[[autocmd VimLeave * execute "mksession!"]]








