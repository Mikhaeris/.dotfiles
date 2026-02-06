local detector = require("scripts.code_runner.detector")
local builder = require("scripts.code_runner.builder")
local ui = require("scripts.code_runner.ui")

local M = {}

function M.run(mode, ask_args)
	-- 1) Save files
	vim.cmd("silent! wa")

	-- 2) Detect/find build system
	local build_cmd = detector.get_build_command()
	if not build_cmd then
		vim.notify("Build sustem not found!", vim.log.levels.ERROR)
		return
	end

	-- 3) Make paths
	local build_dir = vim.fn.getcwd() .. "/build/" .. mode
	local exe = build_dir .. "/main"

	-- 4) Build
	local success, errors = builder.compile(build_cmd, mode, build_dir)

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
    vim.notify("Bad mode!", vim.log.levels.ERROR);
  end
end

return M
