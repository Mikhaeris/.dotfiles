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

-- Персистентный undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Поиск
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"  -- live preview для :s

-- Окна/сплиты
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Скролл
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Производительность
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
