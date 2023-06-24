
return {
  "ggandor/leap.nvim",
  --enabled=false,
  config = function()
    --require("leap").add_default_mappings()
    vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)')
    vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward-to)')
    vim.keymap.set({'n', 'x', 'o'}, 't', '<Plug>(leap-forward-till)')
    vim.keymap.set({'n', 'x', 'o'}, 'T', '<Plug>(leap-backward-till)')
    vim.keymap.set({'n', 'x', 'o'}, 'gs', function() require('leap').leap({ target_windows = require("leap.util").get_enterable_windows() }) end)
  end
}
