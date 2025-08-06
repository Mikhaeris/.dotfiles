return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    window = {
      width = 30,
      position = "left",
    },
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
        never_show = {},
      },
    },
  },
  keys = {
    { "<C-n>", ":Neotree toggle<CR>" },
  },
  -- config = function()
  --   vim.api.nvim_create_autocmd("VimEnter", {
  -- callback = function(data)
  -- if data.file == "" and vim.bo[data.buf].buftype == "" then
  --  require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
  --  end
  --  end,
  --  })
  --  end,
  config = function(_, opts)
    -- применяем ваши opts
    require("neo-tree").setup(opts)

    -- ваша автокоманда
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        if data.file == "" and vim.bo[data.buf].buftype == "" then
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.loop.cwd(),
          })
        end
      end,
    })
  end,
}
