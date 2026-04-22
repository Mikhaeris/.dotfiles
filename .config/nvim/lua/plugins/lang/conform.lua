return {
  "stevearc/conform.nvim",
  keys = {
    { "<leader>cf", '<cmd>lua require("conform").format()<cr>', mode = "n", desc = "Format current buffer" },
  },
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang_format" },
      cpp = { "clang_format" },
    },
  },
}
