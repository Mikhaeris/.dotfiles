local dap = require("dap")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      local s = vim.fn.input("Args (space-separated): ")
      if s == "" then
        return {}
      end
      return vim.split(s, "%s+")
    end,
  },

  {
    name = "Attach to process (pick)",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
  },
}

dap.configurations.c = dap.configurations.cpp
