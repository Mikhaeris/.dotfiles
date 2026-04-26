return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local function build()
      local on_vague = vim.g.colors_name == "vague"

      if not on_vague then
        return { options = { theme = "auto" } }
      end

      local p = _G.MY_PALETTE
        or {
          bg          = "#0c0c0c",
          surface_low = "#1a1a1a",
          surface     = "#2e2e2e",
          fg          = "#ededed",
          fg_strong   = "#ffffff",
          fg_dim      = "#a8a8a8",
          fg_muted    = "#707070",
          fg_subtle   = "#5a5a5a",
          err         = "#f5f5f5",
          warn        = "#c4c4c4",
          info        = "#9c9c9c",
          hint        = "#7a7a7a",
        }

      local mono_theme = {
        normal = {
          a = { fg = p.bg, bg = p.fg_strong, gui = "bold" },
          b = { fg = p.fg, bg = p.surface },
          c = { fg = p.fg_dim, bg = p.surface_low },
        },
        insert  = { a = { fg = p.bg,        bg = "#cfcfcf", gui = "bold" } },
        visual  = { a = { fg = p.bg,        bg = "#a0a0a0", gui = "bold" } },
        replace = { a = { fg = p.fg_strong, bg = "#707070", gui = "bold" } },
        command = { a = { fg = p.bg,        bg = "#b8b8b8", gui = "bold" } },
        inactive = {
          a = { fg = p.fg_muted,  bg = p.surface_low },
          b = { fg = p.fg_muted,  bg = p.surface_low },
          c = { fg = p.fg_subtle, bg = p.bg },
        },
      }

      return {
        options = {
          theme = mono_theme,
        },
        sections = {
          lualine_b = {
            "branch",
            {
              "diff",
              colored = true,
              diff_color = {
                added    = { fg = "#c8c8c8" },
                modified = { fg = p.fg },
                removed  = { fg = p.fg_muted },
              },
            },
            {
              "diagnostics",
              colored = true,
              diagnostics_color = {
                error = { fg = p.err },
                warn  = { fg = p.warn },
                info  = { fg = p.info },
                hint  = { fg = p.hint },
              },
            },
          },
        },
      }
    end

    require("lualine").setup(build())
  end,
}
