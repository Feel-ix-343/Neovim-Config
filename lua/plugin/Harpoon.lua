return {
  "ThePrimeagen/harpoon",
  lazy = true,
  keys = {
    {"<leader>ma", function() require('harpoon.mark').add_file() end, {noremap = true}},
    {"<leader>mc", function() require('harpoon.mark').clear_all() end, {noremap = true}},
    {"<leader>md", function() require('harpoon.mark').rm_file() end, {noremap = true}},

    {"<leader>ms", function() require('harpoon.ui').toggle_quick_menu() end, {noremap = true}},
    {"<leader>mn", function() require('harpoon.ui').nav_next() end, {noremap = true}},
    {"<leader>mp", function() require('harpoon.ui').nav_prev() end, {noremap = true}},
    {"<leader>m1", function () require('harpoon.ui').nav_file(1) end, {noremap = true}},
    {"<leader>m2", function () require('harpoon.ui').nav_file(2) end, {noremap = true}},
    {"<leader>m3", function () require('harpoon.ui').nav_file(3) end, {noremap = true}},
    {"<leader>m4", function () require('harpoon.ui').nav_file(4) end, {noremap = true}},
    {"<leader>m5", function () require('harpoon.ui').nav_file(5) end, {noremap = true}},
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

