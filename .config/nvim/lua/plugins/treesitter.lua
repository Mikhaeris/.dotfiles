return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "asm",
        "lua",
        "c",
        "cpp",
        "pascal",
      },
      highlight = {
        enable = true,
        disable = { "latex" },
      },
      indent = {
        enable = true,
        disable = { "latex" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-g>",
          node_incremental = "<C-k>",
          node_decremental = "<C-j>",
          scope_incremental = "<C-l>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",

            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",

            ["af"] = "@function.outer",
            ["if"] = "@function.inner",

            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]i"] = "@conditional.outer",
            ["]l"] = "@loop.outer",
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]I"] = "@conditional.outer",
            ["]L"] = "@loop.outer",
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[i"] = "@conditional.outer",
            ["[l"] = "@loop.outer",
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[I"] = "@conditional.outer",
            ["[L"] = "@loop.outer",
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },
      },
    })
  end,
}
