return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("vague").setup({
      transparent = false,
      style = {
        comments      = "italic",
        keywords      = "bold",
        functions     = "none",
        strings       = "none",
        variables     = "none",
        types         = "italic",
        keyword_return = "italic",
        booleans      = "bold",
      },
      colors = {
        bg          = "#131313",
        fg          = "#d4d4d4",
        floatBorder = "#3a3a3a",
        line        = "#1f1f1f",

        comment     = "#6b6b78",
        visual      = "#2a2a32",
        search      = "#3a3a48",

        keyword     = "#b8a4d4",
        builtin     = "#c89cb8",

        func        = "#9cc0e0",

        type        = "#86c5c0",

        string      = "#b5c098",

        number      = "#e0b090",
        constant    = "#e0b090",

        property    = "#c8c8d0",
        parameter   = "#d4cfb8",

        operator    = "#a8a8b0",

        error       = "#d47878",
        warning     = "#d4a060",
        hint        = "#86b0c8",
        info        = "#9cc0e0",

        plus        = "#88b090",
        delta       = "#d4a060",
      },
    })
    vim.cmd.colorscheme("vague")
  end,
}
