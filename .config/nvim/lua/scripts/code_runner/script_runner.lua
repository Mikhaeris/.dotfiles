local ui = require("scripts.code_runner.ui")

local M = {}

local runners = {
    py  = "python3",
    lua = "luajit",
    js  = "node",
    ts  = "npx ts-node",
    sh  = "bash",
    rb  = "ruby",
    pl  = "perl",
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

return M
