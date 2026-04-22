return {
  "folke/flash.nvim",
  -- event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>sj", function() require("flash").jump() end, desc = "Flash jump" },
    { "<leader>st", function() require("flash").treesitter() end, desc = "Flash treesitter" },
    { "<leader>sr", function() require("flash").remote() end, desc = "Flash remote" },
    { "<leader>ss", function() require("flash").treesitter_search() end, desc = "Flash TS search" },
  },
}
