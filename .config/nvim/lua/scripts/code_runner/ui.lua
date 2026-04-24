local M = {}

local state = {
  bufnr = nil,
  winid = nil,
}

local function is_valid_buf(bufnr)
  return bufnr and vim.api.nvim_buf_is_valid(bufnr)
end

local function is_valid_win(winid)
  return winid and vim.api.nvim_win_is_valid(winid)
end

local function close_runner_terminal()
  if is_valid_win(state.winid) then
    pcall(vim.api.nvim_win_close, state.winid, true)
  end
  state.winid = nil

  if is_valid_buf(state.bufnr) then
    pcall(vim.api.nvim_buf_delete, state.bufnr, { force = true })
  end
  state.bufnr = nil
end

function M.show_errors(lines)
  vim.cmd("botright 10split")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_win_set_buf(0, buf)
  vim.opt_local.wrap = true
  vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true })
end

function M.run_in_terminal(cmd)
  close_runner_terminal()

  local term_cmd = string.format('printf "\\n--- Program output ---\\n\\n" && %s', cmd)

  vim.cmd("rightbelow vsplit")
  vim.cmd("vertical resize 50")

  state.winid = vim.api.nvim_get_current_win()

  vim.cmd("terminal " .. term_cmd)

  state.bufnr = vim.api.nvim_get_current_buf()

  vim.b[state.bufnr].is_code_runner = true
  vim.api.nvim_buf_set_name(state.bufnr, "code_runner://output-" .. state.bufnr)

  vim.keymap.set("n", "q", function()
    close_runner_terminal()
  end, { buffer = state.bufnr, silent = true, desc = "Close runner" })

  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = state.bufnr,
    once = true,
    callback = function()
      state.bufnr = nil
      state.winid = nil
    end,
  })

  vim.cmd("startinsert")
end

function M.close_runner()
  close_runner_terminal()
end

function M.run_dap(exe, args_str)
  local dap = require("dap")
  dap.run({
    name = "Debug Build",
    type = "codelldb",
    request = "launch",
    program = exe,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = vim.split(args_str, "%s+"),
  })
end

return M
