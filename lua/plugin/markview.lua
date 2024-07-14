-- For plugins/markview.lua users
return {
    "OXY2DEV/markview.nvim",
  enabled = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Used by the code bloxks
    },

    config = function ()
        require("markview").setup({
      list_item = {
    marker_plus = {
        add_padding = true,

        marker = "•",
        marker_hl = "rainbow2"
    },
      }
    });
    end
}
