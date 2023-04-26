return {
  "luukvbaal/statuscol.nvim", 
  event = "VeryLazy",
  config = function()
    -- local builtin = require("statuscol.builtin")
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      -- configuration goes here, for example:
      relculright = true,
      segments = {
        -- { text = { "%C" }, click = "v:lua.ScFa" },
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        { text = { "%s" }, click = "v:lua.ScSa" },
      },
    })
  end,
}
