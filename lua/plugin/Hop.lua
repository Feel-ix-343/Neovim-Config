return {
  "phaazon/hop.nvim",
  event = "VeryLazy",
  config = function ()
    require('hop').setup({keys = 'etovxqpdygfblzhckisuran'})
    -- place this in one of your configuration file(s)
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection

    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
    end, {remap=true})

    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
    end, {remap=true})

    vim.keymap.set('', 't', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
    end, {remap=true})

    vim.keymap.set('', 'T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
    end, {remap=true})

    -- f stands for find; i do this bc h is already mapped
    vim.keymap.set("n", "<leader>fw", ":HopWord<CR>")
    vim.keymap.set("n", "<leader>fp", ":HopPattern<CR>")
    vim.keymap.set("n", "<leader>fl", ":HopLineStart<CR>")
    vim.keymap.set("n", "<leader>fc", ":HopChar1<CR>")
    vim.keymap.set("n", "<leader>ff", ":HopChar2<CR>")



  end
}

