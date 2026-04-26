return {
  "stevearc/conform.nvim",
  keys = {
    { "<leader>cf", '<cmd>lua require("conform").format()<cr>', mode = "n", desc = "Format current buffer" },
  },
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters = {
      ["google-java-format"] = {
        prepend_args = { "--aosp" },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      tex = { "latexindent" },
      java = { "google-java-format" },
    },
  },
}
