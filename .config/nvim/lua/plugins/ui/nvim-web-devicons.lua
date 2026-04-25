return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  config = function()
    local function apply()
      local on_vague = vim.g.colors_name == "vague"

      require("nvim-web-devicons").setup({
        color_icons = not on_vague,
        default = true,
        strict = true,
      })

      if not on_vague then
        return
      end

      local p = _G.MY_PALETTE or { fg = "#ededed" }
      vim.api.nvim_set_hl(0, "DevIconDefault", { fg = p.fg })

      local groups = vim.fn.getcompletion("DevIcon", "highlight")
      for _, g in ipairs(groups) do
        local cur = vim.api.nvim_get_hl(0, { name = g })
        vim.api.nvim_set_hl(0, g, { fg = cur.fg or p.fg, bg = "NONE" })
      end
    end

    apply()

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("my_devicons_refresh", { clear = true }),
      callback = function()
        vim.schedule(apply)
      end,
    })
  end,
}
