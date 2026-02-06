local M = {}

local ft_to_config = {
    cpp = "codelldb",
    c = "codelldb",
    rust = "codelldb",
    python = "debugpy",
}

function M.setup_and_run(mode, args_flag)
    local dap = require('dap')
    local ft = vim.bo.filetype
    local config_name = ft_to_config[ft]

    if not config_name then
        vim.notify("DAP config for " .. ft .. " not found", vim.log.levels.WARN)
        return
    end

    require("dap." .. config_name)

    local config = dap.configurations[ft] and dap.configurations[ft][1]
    
    if config then
        config.program = vim.fn.getcwd() .. "/build/debug/main"
        
        if args_flag == 1 then
            local input = vim.fn.input("Args for Debug: ")
            config.args = vim.split(input, "%s+")
        else
            config.args = {}
        end

        dap.run(config)
    else
        vim.notify("Error: config DAP not loaded", vim.log.levels.ERROR)
    end
end

return M
