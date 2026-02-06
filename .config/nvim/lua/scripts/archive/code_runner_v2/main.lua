local detector = require('scripts.code_runner_v2.detector')
local ui = require('scripts.code_runner_v2.ui')

local M = {}

M.DEBUG = "debug"
M.RELEASE = "release"

function M.run(mode, ask_args)
    vim.cmd('silent! wa')

    local build_tool = detector.get_build_command()
    if not build_tool then
        vim.notify("Build system not found!", vim.log.levels.ERROR)
        return
    end

    local args = ""
    if ask_args == 1 then
        args = vim.fn.input("Arguments: ")
    end

    local build_dir = "./build/" .. mode
    local binary = build_dir .. "/main"

    local compile_cmd = string.format("%s %s %s", build_tool, mode, build_dir)

    ui.execute(compile_cmd, binary, args)
end

return M
