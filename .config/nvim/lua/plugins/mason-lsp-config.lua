return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {}, config = true },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "clangd",
          },
          automatic_installation = true,
        },
      },
    },
    keys = {
      { "K",          vim.lsp.buf.hover,       mode = "n", desc = "LSP: hover" },
      { "<leader>gd", vim.lsp.buf.definition,  mode = "n", desc = "LSP: go to definition" },
      { "<leader>gr", vim.lsp.buf.references,  mode = "n", desc = "LSP: references" },
      { "<leader>ca", vim.lsp.buf.code_action, mode = "n", desc = "LSP: code action" },
    },
    event = "FileType",
    config = function()
      local capabilities = vim.list_extend({}, vim.lsp.protocol.make_client_capabilities())
      capabilities = vim.list_extend(capabilities, require("cmp_nvim_lsp").default_capabilities())
      vim.lsp.config("*", {
        capabilities = capabilities,
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
        update_in_insert = true,
      })
    end,
  },
}
