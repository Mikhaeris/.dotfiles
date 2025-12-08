local M = {}

local cmake_build = require('scripts.code_runner.cmake.build')
local cmake_run = require('scripts.code_runner.cmake.run')

local c_cpp_build = require('scripts.code_runner.C.build')
local c_cpp_run = require('scripts.code_runner.C.run')

local pascal_build = require('scripts.code_runner.Pascal.build')
local pascal_run = require('scripts.code_runner.Pascal.run')

local function file_exists(name)
    local f = io.open(name, "r")
    if f then f:close() return true end
    return false
end

local function detect_source_files()
    local languages = {
        c = "*.c",
        cpp = "*.cpp",
        pascal = "*.pas"
    }

    for lang, pattern in pairs(languages) do
        local p = io.popen("ls " .. pattern .. " 2>/dev/null")
        local result = p:read("*a")
        p:close()
        if result ~= "" then
            return lang
        end
    end
    return nil
end

local function detect_build_system()
    if file_exists("CMakeLists.txt") then
        return {system = "cmake"}
    end

    local lang = detect_source_files()
    if lang then
        return {system = "native", lang = lang}
    end

    error("Cannot detect build system: no CMakeLists.txt or source files found")
end


local function run_project(build_system, config, with_args)
    build_info = build_info or detect_build_system()
    local build_dir = "build/" .. string.lower(config)
    local build_func
    local run_func

    if build_info.system == "cmake" then
        build_func = cmake_build.configure_and_build
        if config == "Debug" then
            run_func = with_args and cmake_run.run_debug_with_args or cmake_run.run_debug
        else
            run_func = with_args and cmake_run.run_release_with_args or cmake_run.run_release
        end
    elseif build_info.system == "native" then
        if build_info.lang == "c" or build_info.lang == "cpp" then
            build_func = c_cpp_build.build_project
            if config == "Debug" then
                run_func = with_args and c_cpp_run.run_debug_with_args or c_cpp_run.run_debug
            else
                run_func = with_args and c_cpp_run.run_release_with_args or c_cpp_run.run_release
            end
        elseif build_info.lang == "pascal" then
            build_func = pascal_build.build_project
            if config == "Debug" then
                run_func = with_args and pascal_run.run_debug_with_args or pascal_run.run_debug
            else
                run_func = with_args and pascal_run.run_release_with_args or pascal_run.run_release
            end
        else
            error("Unsupported native language: " .. tostring(build_info.lang))
        end
    else
        error("Unsupported build system: " .. tostring(build_info.system))
    end

    build_func(build_dir, config, function(result)
        if result == 0 then
            run_func()
            print("✅ Build completed!")
        else
            print("❌ Build error!")
        end
    end)
end

function M.run_debug(build_system)
    run_project(build_system, "Debug", false)
end

function M.run_debug_with_args(build_system)
    run_project(build_system, "Debug", true)
end

function M.run_release(build_system)
    run_project(build_system, "Release", false)
end

function M.run_release_with_args(build_system)
    run_project(build_system, "Release", true)
end

return M
