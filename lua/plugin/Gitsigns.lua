
return {'lewis6991/gitsigns.nvim',
   event = {"BufReadPre", "BufNewFile"},
   opts = {},
   keys = {
    {"<leader>ga", ":Gitsigns stage_hunk<CR>"},
    {"<leader>gr", ":Gitsigns reset_hunk<CR>"},
    {"<leader>gu", ":Gitsigns undo_stage_hunk<CR>"},
    {"<leader>gn", ":Gitsigns next_hunk<CR>"},
    {"<leader>gp", ":Gitsigns prev_hunk<CR>"},
    {"<leader>gh", ":Gitsigns preview_hunk<CR>"},
    {"<leader>gb", ":Gitsigns blame_line<CR>"},
  }
}
