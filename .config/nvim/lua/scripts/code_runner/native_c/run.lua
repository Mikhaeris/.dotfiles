
local M = {}

local dap = require("dap")

local function find_executable(dir)
  if not dir or dir == "" or vim.fn.isdirectory(dir) == 0 then return nil end

  for _, p in ipairs(vim.fn.globpath(dir, "*", true, true)) do
    local stat = vim.loop.fs_stat(p)
    if stat and stat.type == "file" and vim.fn.executable(p) == 1 then
      return p
    end
  end

  return nil
end

-- DEBUG
local function _run_debug(args)
  local exe = find_executable("build/debug")
  if not exe then
    print("❌ No executable found in build/debug/")
    return
  end

  dap.run({
    name = "debug",
    type = "codelldb",
    request = "launch",
    program = exe,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = args or {},
  })
end

function M.run_debug()
  _run_debug({})
end

function M.run_debug_with_args()
  local input_args = vim.fn.input("Program args: ")

  local function shell_split(input)
    local cmd = string.format([[bash -c 'set -- %s; printf "%%s\n" "$@"']], input)
    return vim.fn.systemlist(cmd)
  end

  local args = {}
  if input_args ~= "" then
    args = shell_split(input_args)
  end

  _run_debug(args)
end

-- RELEASE
local function _run_release(args)
  vim.cmd("write")

  local exe = find_executable("build/release")
  if not exe then
    vim.notify("❌ No executable found in build/release", vim.log.levels.ERROR)
    return
  end

  local run_cmd = vim.fn.shellescape(exe)
  if args and args ~= "" then
    run_cmd = run_cmd .. " " .. args
  end

  local term_cmd = string.format('printf "\\n--- Program output ---\\n\\n" && %s', run_cmd)

  vim.cmd("rightbelow vsplit")
  vim.cmd("vertical resize 40")

  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_name(buf, "Run Release")

  vim.fn.termopen({"zsh", "-lc", term_cmd})
  vim.cmd("startinsert")
end

function M.run_release()
  _run_release(nil)
end

function M.run_release_with_args()
  local args = vim.fn.input("Args: ")
  _run_release(args)
end

return M
