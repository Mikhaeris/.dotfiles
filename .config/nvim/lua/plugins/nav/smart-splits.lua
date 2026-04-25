return {
  "mrjones2014/smart-splits.nvim",
  -- lazy = false,
  -- build is optional, only for the "native" tmux integration via CLI
  -- build = "./kitty/install-kittens.bash", -- kitty only, skip
  opts = {
    -- pixel-based resizing (smoother with tmux)
    resize_mode = {
      quit_key = "<ESC>",
      resize_keys = { "h", "j", "k", "l" },
      silent = false,
    },
    -- tmux behaviour
    ignored_buftypes = { "nofile", "quickfix", "prompt" },
    ignored_filetypes = { "NvimTree" },
    default_amount = 3,
    at_edge = "wrap", -- wrap | stop | split
    -- works with vim-tmux-navigator tmux bindings format
    cursor_follows_swapped_bufs = false,
  },
  -- stylua: ignore
  keys = {
    -- navigation between nvim splits AND tmux panes (transparent)
    { "<C-h>", function() require("smart-splits").move_cursor_left() end,  desc = "Move to left split/pane" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end,  desc = "Move to down split/pane" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end,    desc = "Move to up split/pane" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split/pane" },

    -- resize with Alt+hjkl (no conflict with anything)
    { "<A-h>", function() require("smart-splits").resize_left() end,  desc = "Resize left" },
    { "<A-j>", function() require("smart-splits").resize_down() end,  desc = "Resize down" },
    { "<A-k>", function() require("smart-splits").resize_up() end,    desc = "Resize up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize right" },

    -- swap buffers between splits
    { "<leader><leader>h", function() require("smart-splits").swap_buf_left() end,  desc = "Swap buffer left" },
    { "<leader><leader>j", function() require("smart-splits").swap_buf_down() end,  desc = "Swap buffer down" },
    { "<leader><leader>k", function() require("smart-splits").swap_buf_up() end,    desc = "Swap buffer up" },
    { "<leader><leader>l", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
  },
}
