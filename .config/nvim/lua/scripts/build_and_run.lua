vim.keymap.set("n", "<F6>", function()
  vim.cmd("write")

  local src = vim.fn.expand("%:p")
  local out_name = vim.fn.expand("%:t:r")
  local out_path = "build/debug/" .. out_name

  local bash_cmd = string.format(
    'mkdir -p build/debug && g++ -std=c++20 -g -O0 %s -o %s && printf "\\n--- Program output ---\\n\\n" && %s',
    vim.fn.shellescape(src),
    vim.fn.shellescape(out_path),
    vim.fn.shellescape("./" .. out_path)
  )

  vim.cmd("rightbelow vsplit")
  vim.cmd("vertical resize 40")

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_name(buf, "Build: " .. out_name)

  vim.fn.termopen({ "bash", "-lc", bash_cmd })

  vim.cmd("startinsert")
end, { noremap = true, silent = true })
