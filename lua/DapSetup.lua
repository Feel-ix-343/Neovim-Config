local dap = require'dap'
require("mason-nvim-dap").setup({
  automatic_installation = true, -- Install all of debuggers for servers listed in lsp_setup_config
  automatic_setup = true -- Sets up these debuggers. If this does not work, then you will need to set up a server manually like I did for codelldb
})
require'mason-nvim-dap'.setup_handlers({
  function (source_name)
    -- all sources with no handler get passed here
    require('mason-nvim-dap.automatic_setup')(source_name)
  end,
  lldb = function(source_name)
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = 'codelldb',
        args = {"--port", "${port}" }
      }
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          print("Compiling Current File for Debug")
          print("File Name: " .. vim.fn.expand("%"))
          os.execute('g++ -g ' .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r") .. "DEBUG" )
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
      },
    }
  end
})

local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})

