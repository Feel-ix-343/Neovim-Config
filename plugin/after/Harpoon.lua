local harpoonMark = require('harpoon.mark')
local harpoonUi = require('harpoon.ui')

vim.keymap.set("n", "<leader>ma", harpoonMark.add_file, {noremap = true})
vim.keymap.set("n", "<leader>mc", harpoonMark.clear_all, {noremap = true})
vim.keymap.set("n", "<leader>md", harpoonMark.rm_file, {noremap = true})

vim.keymap.set("n", "<leader>ms", harpoonUi.toggle_quick_menu, {noremap = true})
vim.keymap.set("n", "<leader>mn", harpoonUi.nav_next, {noremap = true})
vim.keymap.set("n", "<leader>mp", harpoonUi.nav_prev, {noremap = true})
vim.keymap.set("n", "<leader>m1", function () harpoonUi.nav_file(1) end, {noremap = true})
vim.keymap.set("n", "<leader>m2", function () harpoonUi.nav_file(2) end, {noremap = true})
vim.keymap.set("n", "<leader>m3", function () harpoonUi.nav_file(3) end, {noremap = true})
vim.keymap.set("n", "<leader>m4", function () harpoonUi.nav_file(4) end, {noremap = true})
vim.keymap.set("n", "<leader>m5", function () harpoonUi.nav_file(5) end, {noremap = true})

-- Telescope keybindings are in Telescope.lua




