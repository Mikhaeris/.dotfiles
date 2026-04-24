return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    default_animation = "fade", -- fade | reverse_fade | bounce | left_to_right | pulse | rainbow
    refresh_interval_ms = 8,

    overwrite = {
      auto_map = true,
      yank = {
        enabled = true,
        default_animation = "fade",
      },
      paste = {
        enabled = true,
        default_animation = "reverse_fade",
      },
      undo = {
        enabled = false,
      },
      redo = {
        enabled = false,
      },
      search = {
        enabled = false,
      },
    },

    animations = {
      fade = {
        max_duration = 300,
        chars_for_max_duration = 10,
      },
    },
  },
}
