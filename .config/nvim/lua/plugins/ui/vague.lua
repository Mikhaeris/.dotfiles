return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 1000,
  config = function()
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
        bg          = "#0c0c0c",
        fg          = "#ededed",
        floatBorder = "#4a4a4a",
        line        = "#1a1a1a",

        comment     = "#707070",
        visual      = "#2e2e2e",
        search      = "#454545",

        keyword     = "#ffffff",
        builtin     = "#dcdcdc",

        func        = "#cfcfcf",

        type        = "#bdbdbd",

        string      = "#a8a8a8",

        number      = "#c8c8c8",
        constant    = "#c8c8c8",

        property    = "#e4e4e4",
        parameter   = "#b8b8b8",
        operator    = "#8a8a8a",

        error       = "#f5f5f5",
        warning     = "#c4c4c4",
        hint        = "#7a7a7a",
        info        = "#9c9c9c",

        plus        = "#b8b8b8",
        delta       = "#8a8a8a",
      },
    })
    vim.cmd.colorscheme("vague")
  end,
}
