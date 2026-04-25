return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        if #vim.fn.getbufinfo({ buflisted = 1 }) >= 2 then
          vim.schedule(function()
            require("lazy").load({ plugins = { "bufferline.nvim" } })
          end)
          return true
        end
      end,
    })
  end,
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
    highlights = function()
      local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = normal_bg })
    end,
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
