local M = {}

local dap = require("dap")

local function save_current_buffer()
  if vim.bo.modified then vim.cmd("write") end
end

local function detect_build_system()
  if vim.fn.filereadable("CMakeLists.txt") == 1 then return "cmake" end
  if vim.fn.filereadable("Makefile") == 1 then return "make" end

  local c_files = vim.fn.glob("*.c", false, true)
  local cpp_files = vim.fn.glob("*.cpp", false, true)
  if #c_files > 0 and #cpp_files == 0 then return "gcc" end
  if #cpp_files > 0 then return "g++" end
  return "g++"
end

local function is_executable(path)
  if vim.fn.getftype(path) ~= "file" then return false end
  if vim.fn.executable(path) == 1 then return true end
  return vim.fn.getfperm(path):match("x") ~= nil
end

local function find_executable_in_build_debug(expected_name)
  local outdir = "build/debug"
  if vim.fn.isdirectory(outdir) == 0 then return nil end

  if expected_name then
    local exact = outdir .. "/" .. expected_name
    if vim.fn.filereadable(exact) == 1 and is_executable(exact) then
      return vim.fn.fnamemodify(exact, ":p")
    end
  end

  for _, f in ipairs(vim.fn.glob(outdir .. "/*", false, true)) do
    if is_executable(f) then return vim.fn.fnamemodify(f, ":p") end
  end

  return nil
end

local function build_project()
  local build_system = detect_build_system()

  save_current_buffer()

  if build_system == "cmake" then
    if vim.fn.isdirectory("build") == 0 then os.execute("cmake -S . -B build") end
    print("Compiling with: cmake")
    local ok = os.execute("cmake --build build")
    return (ok == true or ok == 0), nil
  end

  if build_system == "make" then
    print("Compiling with: make")
    local ok = os.execute("make")
    return (ok == true or ok == 0), nil
  end

  local cur = vim.fn.expand("%:p")
  if cur == "" then print("❌ No open file in the buffer"); return false, nil end
  if vim.fn.filereadable(cur) == 0 then print("❌ File not found: " .. cur); return false, nil end

  local ext = vim.fn.expand("%:e")
  if build_system == "gcc" and ext ~= "c" then
    if ext == "cpp" or ext == "cc" or ext == "cxx" then build_system = "g++" end
  elseif build_system == "g++" and not (ext == "cpp" or ext == "cc" or ext == "cxx") then
    if ext == "c" then build_system = "gcc" end
  end

  local base = vim.fn.fnamemodify(cur, ":t:r")
  local outdir = "build/debug"
  if vim.fn.isdirectory(outdir) == 0 then os.execute("mkdir -p " .. vim.fn.shellescape(outdir)) end
  local outpath = outdir .. "/" .. base
  local src_esc = vim.fn.shellescape(cur)
  local out_esc = vim.fn.shellescape(outpath)
  local cmd

  if build_system == "gcc" then
    cmd = string.format("gcc -g -o %s %s", out_esc, src_esc)
  else
    cmd = string.format("g++ -g -o %s %s", out_esc, src_esc)
  end

  print("Compiling with: " .. build_system .. " (file: " .. vim.fn.fnamemodify(cur, ":t") .. ")")
  local ok = os.execute(cmd)
  if ok == true or ok == 0 then
    return true, vim.fn.fnamemodify(outpath, ":t")
  end

  return false, nil
end

function M.build_and_debug()
  local ok, expected_name = build_project()
  if not ok then print("❌ Build error!"); return end

  local exe = find_executable_in_build_debug(expected_name)
  if not exe then
    print("❌ No executable found in build/debug/")
    return
  end

  print("✅ Build completed. Launch: " .. exe)

  dap.run({
    name = "Debug after build",
    type = "codelldb",
    request = "launch",
    program = exe,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = {},
  })
end

function M.build_and_debug_with_args()
  local ok, expected_name = build_project()
  if not ok then
    print("❌ Build error!")
    return
  end

  local exe = find_executable_in_build_debug(expected_name)
  if not exe then
    print("❌ No executable found in build/debug/")
    return
  end

  local input_args = vim.fn.input("Program args: ")

  local function shell_split(input)
    local cmd = string.format([[bash -c 'set -- %s; printf "%%s\n" "$@"']], input)
    return vim.fn.systemlist(cmd)
  end

  local args = {}
  if input_args ~= "" then
    args = shell_split(input_args)
  end

  print("✅ Build completed. Launch: " .. exe ..
        (#args > 0 and (" with args: " .. table.concat(args, " ")) or ""))

  dap.run({
    name = "Debug after build (with args)",
    type = "codelldb",
    request = "launch",
    program = exe,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = args,
  })
end

return M
