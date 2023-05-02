vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {noremap=true})

vim.api.nvim_set_keymap('n', '<leader><leader>',':w<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', {noremap=true})

vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>', {noremap=true}) --mapping backspace to delete the whole word
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', {noremap=true}) --mapping backspace to delete the whole word

vim.api.nvim_set_keymap("n", "<leader>ps", ":PackerSync<CR>", {noremap=true})
vim.keymap.set("n", "<leader>s", ":source %<CR>", {nowait=true, noremap=true})

vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", {noremap=true})
vim.keymap.set("n", "<leader><tab>", ":tabnew<CR>", {noremap=true})


vim.keymap.set("n", "<CR>", "o<esc>", {noremap=true})
vim.keymap.set("n", "<S-CR>", "O<esc>", {noremap=true})
vim.keymap.set("n", "<C-l>", ":ToggleCheckbox<CR>", {noremap=true})
