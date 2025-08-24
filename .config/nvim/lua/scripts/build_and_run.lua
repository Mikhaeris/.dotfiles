local function compile_and_run(prompt_for_args)
  vim.cmd("write")

  local src = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  local out_name = vim.fn.expand("%:t:r")
  local out_path = "build/debug/" .. out_name
  local out_exec = "./" .. out_path

  local compiler
  if ext == "c" then
    compiler = "gcc -std=c11 -g -O0"
  else
    compiler = "g++ -std=c++20 -g -O0"
  end

  local args = ""
  if prompt_for_args then
    args = vim.fn.input("Args: ")
  end

  local run_cmd = vim.fn.shellescape(out_exec)
  if args ~= "" then
    run_cmd = run_cmd .. " " .. args
  end

  local zsh_cmd = string.format(
    'mkdir -p build/debug && %s %s -o %s && printf "\\n--- Program output ---\\n\\n" && %s',
    compiler,
    vim.fn.shellescape(src),
    vim.fn.shellescape(out_path),
    run_cmd
  )

  vim.cmd("rightbelow vsplit")
  vim.cmd("vertical resize 40")

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_name(buf, "Build: " .. out_name)

  vim.fn.termopen({ "zsh", "-lc", zsh_cmd })

  vim.cmd("startinsert")
end

vim.keymap.set("n", "<F7>", function() compile_and_run(false) end, { noremap = true, silent = true })

vim.keymap.set("n", "<F8>", function() compile_and_run(true) end, { noremap = true, silent = true })
