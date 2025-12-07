return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    {
      "<F1>",
      function()
        require("dap").terminate();
      end,
      desc = "DAP: terminate terminal"
    },
    {
      "<Leader>b",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP: Toggle Breakpoint",
    },
    {
      "<F9>",
      function()
        require("dap").continue()
      end,
      desc = "DAP: Continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "DAP: Step Over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "DAP: Step Into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "DAP: Step Out",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "threads",     size = 0.1 },
            { id = "watches",     size = 0.2 },
            { id = "stacks",      size = 0.2 },
            { id = "breakpoints", size = 0.1 },
            { id = "scopes",      size = 0.5 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl",    size = 0.6 },
            { id = "console", size = 0.4 },
          },
          size = 12,
          position = "bottom",
        },
      },
    })

    require("nvim-dap-virtual-text").setup({
      enabled = true,
      commented = false,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      virt_text_pos = "eol",
    })

    vim.fn.sign_define("DapBreakpoint", { numhl = "DapBreakpointNum" })
    vim.fn.sign_define("DapBreakpointCondition", { numhl = "DapBreakpointConditionNum" })
    vim.fn.sign_define("DapStopped", { linehl = "Visual", numhl = "DapStoppedNum" })

    vim.api.nvim_set_hl(0, "DapBreakpointNum", { fg = "#993636", bg = nil })
    vim.api.nvim_set_hl(0, "DapBreakpointConditionNum", { fg = "#AF791F", bg = nil })
    vim.api.nvim_set_hl(0, "DapStoppedNum", { fg = "#739650", bg = nil })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    require("dap.codelldb")

    local launch = require('scripts.code_runner.main')
    vim.keymap.set('n', '<F5>', function() launch.run_debug() end, {silent=true})
    vim.keymap.set('n', '<F6>', function() launch.run_debug_with_args() end, {silent=true})

    vim.keymap.set("n", "<F7>", function() launch.run_release() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<F8>", function() launch.run_release_with_args() end, { noremap = true, silent = true })
  end,
}
