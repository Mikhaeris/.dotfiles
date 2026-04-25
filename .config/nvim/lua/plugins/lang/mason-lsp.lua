return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "K", vim.lsp.buf.hover, desc = "LSP Hover" },
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gr", vim.lsp.buf.references, desc = "References" },
      { "gi", vim.lsp.buf.implementation, desc = "Goto Implementation" },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      if package.loaded["blink.cmp"] then
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      end

      vim.lsp.config("*", { capabilities = capabilities })
      vim.lsp.config("clangd", require("lsp.clangd"))

      vim.lsp.enable({
        "lua_ls",
        "clangd",
        "jdtls",
        "asm_lsp",
        "texlab",
        "pyright",
        "stylua",
        "html",
        "cssls",
        "emmet_language_server",
      })

      vim.opt.signcolumn = "no"
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
          },
        },
        update_in_insert = false,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "jdtls",
        "asm_lsp",
        "texlab",
        "pyright",
        "stylua",
        "html",
        "cssls",
        "emmet_language_server",
      },
      automatic_installation = false,
    },
  },
}
