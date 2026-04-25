local function try_cmd(cmd, warn)
  local ok, err = pcall(vim.cmd, cmd)
  if not ok and warn then
    vim.notify(warn .. "\n" .. err, vim.log.levels.WARN)
  end
end

local function open_preset()
  try_cmd("Neotree show", "edgy preset: neo-tree is not enabled (plugins/nav/neo-tree.lua -> enabled = true)")

  vim.schedule(function()
    try_cmd("Outline")
  end)

  vim.schedule(function()
    local ok, TT = pcall(require, "toggleterm.terminal")
    if not ok then
      return
    end
    local id = 60
    local term = TT.get(id)
      or TT.Terminal:new({
        id = id,
        direction = "horizontal",
        display_name = "edgy-term",
      })
    if not term:is_open() then
      term:open()
    end
  end)

  vim.schedule(function()
    pcall(function()
      require("edgy").goto_main()
    end)
  end)
end

return {
  "folke/edgy.nvim",
  -- event = "VeryLazy",
  dependencies = {
    "nvim-neo-tree/neo-tree.nvim",
    "hedyhli/outline.nvim",
    "stevearc/overseer.nvim",
  },
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  -- stylua: ignore
  keys = {
    { "<leader>ue", function() require("edgy").toggle() end, desc = "Edgy toggle" },
    { "<leader>uE", open_preset,                             desc = "Edgy preset layout" },
    { "<leader>uw", function() require("edgy").select() end, desc = "Edgy pick window" },

    -- per-panel toggles
    { "<leader>un", "<cmd>Neotree toggle<cr>",                       desc = "Toggle Neo-tree" },
    { "<leader>uo", "<cmd>Outline<cr>",                              desc = "Toggle Outline" },
    { "<leader>uO", "<cmd>OverseerToggle<cr>",                       desc = "Toggle Overseer" },
  },
  opts = {
    wo = {
      winhighlight = "NormalNC:Normal,WinSeparator:WinSeparator",
    },
    exit_when_last = false,
    bottom = {
      {
        ft = "toggleterm",
        size = { height = 0.25 },
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      "Trouble",
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      { ft = "OverseerOutput", title = "Task Output", size = { height = 0.3 } },

      -- DAP
      { ft = "dap-repl", title = "DAP REPL", size = { height = 0.25 } },
      { ft = "dapui_console", title = "DAP Console", size = { height = 0.25 } },
    },
    left = {
      {
        title = "Neo-Tree",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        size = { height = 0.6 },
      },
      {
        title = "Outline",
        ft = "Outline",
        pinned = true,
        open = "Outline",
      },

      -- DAP UI
      { title = "Threads", ft = "dapui_threads", pinned = true, open = "DapNew" },
      { title = "Scopes", ft = "dapui_scopes" },
      { title = "Breakpoints", ft = "dapui_breakpoints", pinned = true, open = "DapNew" },
      { title = "Stacks", ft = "dapui_stacks", pinned = true, open = "DapNew" },
      { title = "Watches", ft = "dapui_watches" },
    },
    right = {
      {
        title = "Overseer",
        ft = "OverseerList",
        size = { width = 0.2 },
      },
    },
  },
}
