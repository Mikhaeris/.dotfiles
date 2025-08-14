local M = {}

local dap = require("dap")

local function detect_build_system()
  if vim.fn.filereadable("CMakeLists.txt") == 1 then
    return "cmake"
  elseif vim.fn.filereadable("Makefile") == 1 then
    return "make"
  end
  return "g++"
end

local function is_executable(f)
  if vim.fn.getftype(f) ~= "file" then return false end
  local check_path = f:match("[/\\]") and f or "./" .. f
  if vim.fn.executable(check_path) == 1 then return true end
  return vim.fn.getfperm(f):match("x") ~= nil
end

local function find_executable()
  local patterns = vim.fn.isdirectory("build") == 1 and { "build/*", "*" } or { "*" }

  for _, pat in ipairs(patterns) do
    for _, f in ipairs(vim.fn.glob(pat, false, true)) do
      if is_executable(f) then
        return vim.fn.fnamemodify(f, ":p")
      end
    end
  end
  return nil
end

local function build_project()
  local build_system = detect_build_system()
  local cmd

  if build_system == "cmake" then
    if vim.fn.isdirectory("build") == 0 then
      os.execute("cmake -S . -B build")
    end
    cmd = "cmake --build build"
  elseif build_system == "make" then
    cmd = "make"
  else
    cmd = "g++ -g -o main *.cpp"
  end

  print("Compiling with: " .. build_system)
  return os.execute(cmd) == 0
end

function M.build_and_debug()
  if not build_project() then
    print("❌ Build error!")
    return
  end

  local exe = find_executable()
  if not exe then
    print("❌ No executable file found!")
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

return M
