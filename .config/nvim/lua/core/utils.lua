-- indentation per filetype
local indent_group = vim.api.nvim_create_augroup("FileTypeTabs", { clear = true })

local indent_map = {
  lua        = 2,
  zsh        = 2,
  css        = 2,
  javascript = 2,
  typescript = 2,
  c          = 4,
  cpp        = 4,
  pascal     = 4,
  html       = 4,
  java       = 4,
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

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h", "*.lua", "*.py" },
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})
