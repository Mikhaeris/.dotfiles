local M = {}

local error_buf = nil
local term_buf = nil

function M.execute(compile_cmd, binary, args)
    if error_buf and vim.api.nvim_buf_is_valid(error_buf) then
        vim.api.nvim_buf_delete(error_buf, { force = true })
    end

    vim.fn.jobstart(compile_cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stderr = function(_, data)
            if data and #data > 1 then
                M.show_errors(data)
            end
        end,
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                M.run_in_terminal(binary .. " " .. args)
            else
                vim.notify("Build error!", vim.log.levels.WARN)
            end
        end
    })
end

function M.show_errors(data)
    vim.cmd('botright 10split')
    error_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(error_buf, 0, -1, false, data)
    vim.api.nvim_win_set_buf(0, error_buf)
    vim.opt_local.wrap = true
end

function M.run_in_terminal(cmd)
    vim.cmd('vertical rightbelow split')
    vim.cmd('terminal ' .. cmd)
    vim.cmd('startinsert')
end

return M
