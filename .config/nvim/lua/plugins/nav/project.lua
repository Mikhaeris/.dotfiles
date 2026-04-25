return {
  "DrKJeff16/project.nvim",
  dependencies = {
    "folke/snacks.nvim",
    "stevearc/resession.nvim",
  },
  cmd = { "ProjectSnacks", "ProjectTelescope", "ProjectRoot", "ProjectRecents" },
  keys = {
    {
      "<leader>pp",
      function()
        require("project")._session_active = true
        vim.cmd("ProjectSnacks")
      end,
      desc = "Projects: picker & sessions",
    },
    {
      "<leader>pr",
      function()
        require("project")._session_active = true
        require("resession").load(vim.fn.getcwd(), { dir = "dirsession", reset = true })
      end,
      desc = "Projects: load session here",
    },
    {
      "<leader>pa",
      function()
        require("project")._session_active = true
        vim.cmd("ProjectAdd!")
      end,
      desc = "Projects: add current cwd",
    },
  },
  opts = {
    detection_methods = {
      "lsp",
      "pattern",
    },
    patterns = {
      ".git",
      "Makefile",
    },

    silent_chdir = true,
    scope_chdir = "global",
    enable_autochdir = false,

    snacks = {
      enabled = true,
      opts = {
        sort = "newest",
        hidden = false,
        title = "Select Project",
        layout = "select",
        -- icon {},
        -- path_icons = {},
      },
    },
  },
  config = function(_, opts)
    require("project").setup(opts)

    local resession = require("resession")

    -- Save before change project
    vim.api.nvim_create_autocmd("DirChangedPre", {
      callback = function()
        if require("project")._session_active then
          resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
        end
      end,
    })

    -- Load seesion if directory changed
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        if require("project")._session_active then
          resession.load(vim.fn.getcwd(), { dir = "dirsession", reset = true, silence_errors = true })
        end
      end,
    })

    -- Save in close
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        if require("project")._session_active then
          resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
        end
      end,
    })
  end,
}
