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

    if vim.g.my_theme == "vague" then
      vim.cmd.colorscheme("vague")
    end
  end,
}
