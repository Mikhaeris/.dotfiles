local builder = require("scripts.code_runner.builder")
local detector = require("scripts.code_runner.detector")
local script_runner = require("scripts.code_runner.script_runner")
local single_file = require("scripts.code_runner.single_file")
local ui = require("scripts.code_runner.ui")

local M = {}

function M.run(mode, ask_args)
  -- check
  if mode ~= "debug" and mode ~= "release" then
    vim.notify("Bad mode: " .. tostring(mode), vim.log.levels.ERROR)
    return
  end

  -- 1) Save files
  vim.cmd("silent! wa")

  -- additional) check if its script
  if script_runner.is_script() then
    if mode == "debug" then
      script_runner.debug(ask_args)
    else
      script_runner.run(ask_args)
    end
    return
  end

  -- 2) Detect/find build system
  local build_cmd = detector.get_build_command()

  -- 3) Make paths
  local build_dir = vim.fn.getcwd() .. "/build/" .. mode
  local exe = build_dir .. "/main"

  -- 4) Build with fallback
  local success, errors
  if build_cmd then
    success, errors = builder.compile(build_cmd, mode, build_dir)
  elseif single_file.can_compile() then
    vim.notify("No build system found, compiling current buffer...", vim.log.levels.INFO)
    success, errors = single_file.compile(mode, build_dir)
  else
    vim.notify("Build system not found and no single-file compiler for: " .. vim.bo.filetype, vim.log.levels.ERROR)
    return
  end

  -- 5) Check for error build
  if not success then
    ui.show_errors(errors)
    return
  end

  -- 6) Get args
  local args_str = ""
  if ask_args == 1 then
    args_str = vim.fn.input("Arguments: ")
  end

  -- 7) Run DAP or Terminal
  if mode == "debug" then
    ui.run_dap(exe, args_str)
  elseif mode == "release" then
    ui.run_in_terminal(exe .. " " .. args_str)
  else
    vim.notify("Bad mode!", vim.log.levels.ERROR)
  end
end

return M
