local function run(mode, args)
  return function()
    require("scripts.code_runner.main").run(mode, args)
  end
end

return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "Weissle/persistent-breakpoints.nvim",
    },
    -- stylua: ignore
    keys = {
      -- { "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
      { "<F1>", function() require("dap").terminate() end, desc = "DAP: Terminate" },
      { "<F9>", function() require("dap").continue() end, desc = "DAP: Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP: Step Out" },

      { "<F5>", run("debug", 0), desc = "Build and start debug", silent = true },
      { "<F6>", run("debug", 1), desc = "Build and start debug with args", silent = true },
      { "<F7>", run("release", 0), desc = "Build and run code", silent = true },
      { "<F8>", run("release", 1), desc = "Build and run code with args", silent = true },
    },
    config = function()
      local ok, mason_dap = pcall(require, "mason-nvim-dap")
      if ok then
        mason_dap.setup({ automatic_installation = true, handlers = {}, ensure_installed = { "codelldb", "debugpy" } })
      end
      vim.fn.sign_define("DapBreakpoint", { numhl = "DapBreakpointNum" })
      vim.fn.sign_define("DapBreakpointCondition", { numhl = "DapBreakpointConditionNum" })
      vim.fn.sign_define("DapStopped", { linehl = "Visual", numhl = "DapStoppedNum" })

      vim.api.nvim_set_hl(0, "DapBreakpointNum", { fg = "#993636", bg = nil })
      vim.api.nvim_set_hl(0, "DapBreakpointConditionNum", { fg = "#AF791F", bg = nil })
      vim.api.nvim_set_hl(0, "DapStoppedNum", { fg = "#739650", bg = nil })

      require("dap_configs.init")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "x"} },
    },
    opts = {
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.40 },
            { id = "breakpoints", size = 0.10 },
            { id = "watches", size = 0.20 },
            { id = "stacks", size = 0.20 },
            { id = "threads", size = 0.10 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.6 },
            { id = "console", size = 0.4 },
          },
          size = 12,
          position = "bottom",
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    opts = {
      enabled = true,
      commented = false,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      virt_text_pos = "eol",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    dependencies = { "williamboman/mason.nvim" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        "codelldb",
        "debugpy",
        "java-debug-adapter",
      },
    },
    config = function() end,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap" },
  -- stylua: ignore
  keys = {
    { "<leader>db", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Breakpoint: toggle (persistent)" },
    { "<leader>dB", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end, desc = "Breakpoint: conditional" },
    { "<leader>dC", function() require("persistent-breakpoints.api").clear_all_breakpoints() end, desc = "Breakpoint: clear all" },
  },
    opts = {
      load_breakpoints_event = { "BufReadPost" },
      save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
      perf_record = false,
    },
    config = function(_, opts)
      require("persistent-breakpoints").setup(opts)
      local api = require("persistent-breakpoints.api")
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted then
          pcall(api.load_breakpoints, b)
        end
      end
    end,
  },
}
