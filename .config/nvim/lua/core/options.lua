-- terminal color
vim.opt.termguicolors = true

-- leader key
vim.g.mapleader = " "

-- relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- width tab
vim.cmd([[
  augroup FileTypeTabs
    autocmd!
    autocmd FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType zsh setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType c   setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
  augroup END
]])

-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4
-- vim.opt.expandtab = true
