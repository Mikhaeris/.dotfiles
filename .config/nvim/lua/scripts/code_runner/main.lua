local M = {}

local cmake_build = require('scripts.code_runner.cmake.build')
local cmake_run = require('scripts.code_runner.cmake.run')

local native_build = require('scripts.code_runner.native_c.build')
local native_run = require('scripts.code_runner.native_c.run')

local function file_exists(name)
    local f = io.open(name, "r")
    if f then f:close() return true end
    return false
end

local function has_c_or_cpp_files()
    local p = io.popen("ls *.c *.cpp 2>/dev/null")
    local result = p:read("*a")
    p:close()
    return result ~= ""
end

local function detect_build_system()
    if file_exists("CMakeLists.txt") then
        return "cmake"
    elseif has_c_or_cpp_files() then
        return "native"
    else
        error("Cannot detect build system: no CMakeLists.txt or C/C++ source files found")
    end
end

local function run_project(build_system, config, with_args)
    build_system = build_system or detect_build_system()
    local build_dir = "build/" .. string.lower(config)
    local build_func
    local run_func

    if build_system == "cmake" then
        build_func = cmake_build.configure_and_build
        if config == "Debug" then
            run_func = with_args and cmake_run.run_debug_with_args or cmake_run.run_debug
        else
            run_func = with_args and cmake_run.run_release_with_args or cmake_run.run_release
        end
    elseif build_system == "native" then
        build_func = native_build.build_project
        if config == "Debug" then
            run_func = with_args and native_run.run_debug_with_args or native_run.run_debug
        else
            run_func = with_args and native_run.run_release_with_args or native_run.run_release
        end
    else
        error("Unsupported build system: " .. tostring(build_system))
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
