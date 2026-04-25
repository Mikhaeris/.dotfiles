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
  config = function(_, opts)
    local glimmer = require("tiny-glimmer")
    glimmer.setup(opts)

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("my_tiny_glimmer_refresh", { clear = true }),
      callback = function()
        vim.schedule(function()
          glimmer.setup(opts)
        end)
      end,
    })
  end,
}
