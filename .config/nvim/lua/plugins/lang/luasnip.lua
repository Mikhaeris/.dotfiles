return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    updateevents = "TextChanged,TextChangedI",
    region_check_events = "CursorMoved",
  },
  config = function(_, opts)
    local ls = require("luasnip")
    ls.setup(opts)

    require("luasnip.loaders.from_vscode").lazy_load()

    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.choice_active() then ls.change_choice(1) end
    end, { desc = "LuaSnip: next choice" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if ls.expand_or_jumpable() then ls.expand_or_jump() end
    end, { desc = "LuaSnip: expand/jump" })

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if ls.jumpable(-1) then ls.jump(-1) end
    end, { desc = "LuaSnip: jump back" })
  end,
}
