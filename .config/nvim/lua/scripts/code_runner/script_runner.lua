local ui = require("scripts.code_runner.ui")

local M = {}

local runners = {
	py = "python3",
	lua = "luajit",
	js = "node",
	ts = "npx ts-node",
	sh = "bash",
	rb = "ruby",
	pl = "perl",
}

local dap_configs = {
    py = {
        type    = "python",
        request = "launch",
        name    = "Debug Script (Python)",
    },
    js = {
        type    = "node2",
        request = "launch",
        name    = "Debug Script (Node)",
    },
}

-- check if current file if script
function M.is_script()
	local ext = vim.fn.expand("%:e")
	return runners[ext] ~= nil
end

-- run current file
function M.run(ask_args)
	local ext = vim.fn.expand("%:e")
	local interpreter = runners[ext]
	if not interpreter then
		vim.notify("No interpreter for: " .. ext, vim.log.levels.ERROR)
		return
	end

	local file = vim.fn.expand("%:p")
	local args_str = ""
	if ask_args == 1 then
		args_str = vim.fn.input("Arguments: ")
	end

	ui.run_in_terminal(interpreter .. " " .. file .. " " .. args_str)
end

-- debug current script via DAP
function M.debug(ask_args)
	local ext = vim.fn.expand("%:e")
	local cfg = dap_configs[ext]
	if not cfg then
		vim.notify("No DAP config for '." .. ext .. "', falling back to terminal.", vim.log.levels.WARN)
		M.run(ask_args)
		return
	end

	local file = vim.fn.expand("%:p")
	local args_str = ""
	if ask_args == 1 then
		args_str = vim.fn.input("Arguments: ")
	end

	local dap = require("dap")
	dap.run(vim.tbl_extend("force", cfg, {
		program = file,
		cwd = vim.fn.getcwd(),
		args = vim.split(args_str, "%s+"),
	}))
end

return M
