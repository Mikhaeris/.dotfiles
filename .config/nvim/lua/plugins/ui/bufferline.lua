return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,
  opts = {
    options = {
      mode = "buffers",
      -- separator_style = "thin",
      -- indicator = { style = "underline" },
      diagnostics = "nvim_lsp",

      offsets = {
        {
          filetype = "neo-tree",
          text = "Sidebar",
          text_align = "center",
          separator = false,
        },
        {
          filetype = "Outline",
          text = "Sidebar",
          text_align = "center",
          separator = false,
        },
      },
    },
  },
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", mode = "n", silent = true },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", mode = "n", silent = true },

    { "<leader>b1", "1gt", desc = "Tab 1" },
    { "<leader>b2", "2gt", desc = "Tab 2" },
    { "<leader>b3", "3gt", desc = "Tab 3" },
    { "<leader>bn", "<cmd>tabnew<CR>", desc = "New Tab" },
    { "<leader>bc", "<cmd>tabclose<CR>", desc = "Close Tab" },
  },
}
