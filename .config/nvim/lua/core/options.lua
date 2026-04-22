-- terminal color
vim.opt.termguicolors = true

-- leader key
vim.g.mapleader = " "

-- relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation per filetype
local indent_group = vim.api.nvim_create_augroup("FileTypeTabs", { clear = true })

local indent_map = {
  lua            = 2,
  zsh            = 2,
  css            = 2,
  javascript     = 2,
  typescript     = 2,
  c              = 4,
  cpp            = 4,
  pascal         = 4,
  html           = 4,
}

vim.api.nvim_create_autocmd("FileType", {
  group = indent_group,
  pattern = vim.tbl_keys(indent_map),
  callback = function(ev)
    local w = indent_map[vim.bo[ev.buf].filetype]
    if w then
      vim.opt_local.tabstop = w
      vim.opt_local.shiftwidth = w
      vim.opt_local.expandtab = true
    end
  end,
})

vim.opt.list = true
vim.opt.listchars = {
  trail = "·",
  --   space = "·",
  tab = "  ",
  --   tab = "→ ",
  --   eol = "↴",
}

-- system clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.fillchars:append({ eob = " " })
