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
        bg          = "#131313",
        fg          = "#cfcfcf",
        floatBorder = "#3a3a3a",
        line        = "#1f1f1f",

        comment     = "#5e5e64",
        visual      = "#262629",
        search      = "#33333a",

        keyword     = "#b0a8b8",
        builtin     = "#b4a8ae",

        func        = "#a8b4c0",

        type        = "#a0b4b0",

        string      = "#a8b0a0",

        number      = "#bcb0a4",
        constant    = "#bcb0a4",

        property    = "#c0c0c4",
        parameter   = "#bcbcb8",
        operator    = "#9c9ca0",

        error       = "#c07878",
        warning     = "#b89868",
        hint        = "#8898a4",
        info        = "#98a8b4",

        plus        = "#88a088",
        delta       = "#b89868",
      },
    })
    vim.cmd.colorscheme("vague")
  end,
}
