
return {
  "ecthelionvi/NeoComposer.nvim",
  event = "VeryLazy",
  dependencies = { "kkharji/sqlite.lua" },
  opts = {
    notify = true,
    delay_timer = "500",
    status_bg = "#16161e",
    preview_fg = "#ff9e64",
    keymaps = {
      play_macro = "Q",
      yank_macro = "yq",
      stop_macro = "cq",
      toggle_record = "q",
      cycle_next = "<leader>mn",
      cycle_prev = "<leader>mp",
      toggle_macro_menu = "<m-q>",
    },
  }
}
