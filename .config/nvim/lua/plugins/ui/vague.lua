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
        -- база
        bg          = "#131313",
        fg          = "#cfcfcf",
        floatBorder = "#3a3a3a",
        line        = "#1f1f1f",

        -- UI
        comment     = "#5e5e64",  -- тусклый, уходит назад
        visual      = "#262629",
        search      = "#33333a",

        -- keyword — холодный серо-фиолетовый, едва уловимый
        keyword     = "#b0a8b8",
        -- builtin — чуть теплее keyword, но тоже почти серый
        builtin     = "#b4a8ae",

        -- функции — холодный стальной серый с намёком на голубой
        func        = "#a8b4c0",

        -- типы — серый с лёгким teal
        type        = "#a0b4b0",

        -- строки — серый с лёгкой зеленцой (sage, очень приглушённый)
        string      = "#a8b0a0",

        -- числа — серый с лёгкой тёплой ноткой
        number      = "#bcb0a4",
        constant    = "#bcb0a4",

        -- нейтральные
        property    = "#c0c0c4",
        parameter   = "#bcbcb8",
        operator    = "#9c9ca0",

        -- диагностика — оставляем чуть ярче, это сигналы
        error       = "#c07878",
        warning     = "#b89868",
        hint        = "#8898a4",
        info        = "#98a8b4",

        -- git
        plus        = "#88a088",
        delta       = "#b89868",
      },
    })
    vim.cmd.colorscheme("vague")
  end,
}
