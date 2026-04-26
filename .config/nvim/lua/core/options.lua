-- terminal color
vim.opt.termguicolors = true

-- leader key
vim.g.mapleader = " "

-- relative number
vim.opt.number = true
vim.opt.relativenumber = true


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

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"  -- live preview for :s

-- Windows/Split Systems
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- "vague" | "catppuccin"
vim.g.my_theme = vim.g.my_theme or "catppuccin"
