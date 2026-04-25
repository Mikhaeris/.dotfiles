return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    delay = 500,
    icons = {
      mappings = false,
    },
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = false,
      },
    },

    triggers = {
      { "<leader>", mode = { "n", "v" } },
      { "<auto>", mode = "nxso" },
    },

    disable = {
      buftypes = {},
      filetypes = {},
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer keymaps",
    },
    {
      "<leader>/",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Global keymaps",
    },
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debugger" },
      { "<leader>f", group = "files/find" },
      { "<leader>g", group = "git" },
      { "<leader>o", group = "tools/overseer" },
      { "<leader>p", group = "project" },
      { "<leader>r", group = "runner" },
      { "<leader>s", group = "search/jump" },
      { "<leader>t", group = "terminal" },
      { "<leader>u", group = "ui/toggle" },
      { "<leader>x", group = "diagnostics" },

      { "<leader>tp", group = "preset" },
      { "<leader><leader>", group = "swap splits" },

      { "<leader>?", desc = "Buffer keymaps help" },
      { "<leader>/", desc = "Global keymaps help" },
    })
  end,
}
