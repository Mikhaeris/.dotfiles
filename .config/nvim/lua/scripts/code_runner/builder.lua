local M = {}

function M.compile(cmd, mode, build_dir)
    -- CMake (debug -> Debug)
    local cmake_mode = mode:sub(1,1):upper() .. mode:sub(2)
    local full_cmd = ""

    -- Run command build
    if cmd == "cmake" then
        full_cmd = string.format(
            "cmake -B %s -DCMAKE_BUILD_TYPE=%s && cmake --build %s",
            build_dir, cmake_mode, build_dir
        )
    else
        vim.fn.mkdir(build_dir, "p")
        full_cmd = string.format("%s %s %s", cmd, mode, build_dir)
    end

    local output = vim.fn.systemlist(full_cmd)
    local exit_code = vim.v.shell_error

    if exit_code ~= 0 then
        return false, output
    end
    return true, nil
end

return M
