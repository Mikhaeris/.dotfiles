return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = { preset = "luasnip" },

    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    signature = { enabled = true },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
          },
        },
      },
      ghost_text = { enabled = true },
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
  end,
}
