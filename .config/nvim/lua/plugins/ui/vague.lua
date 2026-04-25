return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local p = {
      bg          = "#0c0c0c",
      surface_low = "#1a1a1a",
      surface     = "#2e2e2e",
      surface_hi  = "#454545",
      border      = "#4a4a4a",

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

    require("vague").setup({
      transparent = false,
      style = {
        comments       = "italic",
        keywords       = "bold",
        functions      = "none",
        strings        = "none",
        variables      = "none",
        types          = "italic",
        keyword_return = "italic",
        booleans       = "bold",
      },
      colors = {
        bg          = p.bg,
        fg          = p.fg,
        floatBorder = p.border,
        line        = p.surface_low,

        comment     = p.fg_muted,
        visual      = p.surface,
        search      = p.surface_hi,

        keyword     = p.fg_strong,
        builtin     = "#dcdcdc",
        func        = "#cfcfcf",
        type        = "#bdbdbd",
        string      = p.fg_dim,
        number      = "#c8c8c8",
        constant    = "#c8c8c8",
        property    = "#e4e4e4",
        parameter   = "#b8b8b8",
        operator    = "#8a8a8a",

        error       = p.err,
        warning     = p.warn,
        hint        = p.hint,
        info        = p.info,

        plus        = "#b8b8b8",
        delta       = "#8a8a8a",
      },
    })

    _G.MY_PALETTE = p

    local function overrides()
      local set = vim.api.nvim_set_hl

      set(0, "EdgyTitle",       { fg = p.fg_dim,    bg = "NONE" })
      set(0, "EdgyTitleActive", { fg = p.fg_strong, bg = "NONE", bold = true })
      set(0, "EdgyIcon",        { fg = p.fg_dim,    bg = "NONE" })
      set(0, "EdgyIconActive",  { fg = p.fg_strong, bg = "NONE" })
      set(0, "EdgyWinBar",      { fg = p.fg,        bg = "NONE" })
      set(0, "WinBar",          { fg = p.fg,        bg = "NONE" })
      set(0, "WinBarNC",        { fg = p.fg_dim,    bg = "NONE" })

      set(0, "WhichKey",          { fg = p.fg_strong, bold = true })
      set(0, "WhichKeyGroup",     { fg = p.fg_dim, italic = true })
      set(0, "WhichKeyDesc",      { fg = p.fg })
      set(0, "WhichKeySeparator", { fg = p.fg_muted })
      set(0, "WhichKeyFloat",     { bg = p.surface_low })
      set(0, "WhichKeyNormal",    { bg = p.surface_low })
      set(0, "WhichKeyBorder",    { fg = p.border, bg = p.surface_low })
      set(0, "WhichKeyTitle",     { fg = p.fg_strong, bold = true })
      set(0, "WhichKeyValue",     { fg = p.fg_dim })

      local function notif(level, fg)
        set(0, "SnacksNotifier"        .. level, { fg = fg,         bg = p.surface_low })
        set(0, "SnacksNotifierBorder"  .. level, { fg = p.border,   bg = p.surface_low })
        set(0, "SnacksNotifierTitle"   .. level, { fg = fg,         bg = p.surface_low, bold = true })
        set(0, "SnacksNotifierIcon"    .. level, { fg = fg,         bg = p.surface_low })
        set(0, "SnacksNotifierFooter"  .. level, { fg = p.fg_muted, bg = p.surface_low })
      end
      notif("Error", p.err)
      notif("Warn",  p.warn)
      notif("Info",  p.info)
      notif("Debug", p.hint)
      notif("Trace", p.hint)
      set(0, "SnacksNotifierHistory", { fg = p.fg, bg = p.surface_low })
      set(0, "SnacksNotifierMinimal", { fg = p.fg, bg = p.surface_low })

      set(0, "FloatBorder",  { fg = p.border,   bg = "NONE" })
      set(0, "NormalFloat",  { fg = p.fg,       bg = p.surface_low })
      set(0, "TabLineFill",  { bg = p.bg })
      set(0, "StatusLineNC", { fg = p.fg_muted, bg = p.surface_low })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "vague",
      callback = overrides,
    })

    if vim.g.my_theme == "vague" then
      vim.cmd.colorscheme("vague")
    end
  end,
}
