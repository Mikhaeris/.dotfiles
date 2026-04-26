local M = {}

local function make_cmd(compiler, flags, file, out)
  local cmd = { compiler }
  vim.list_extend(cmd, flags)
  vim.list_extend(cmd, { file, "-o", out })
  return cmd
end

local compilers = {
  c = function(file, out, mode)
    local flags = mode == "debug"
        and { "-g3", "-O0", "-Wall", "-Wextra" }
        or { "-O2", "-DNDEBUG", "-Wall", "-Wextra" }
    return make_cmd("clang", flags, file, out)
  end,

  cpp = function(file, out, mode)
    local flags = mode == "debug"
        and { "-g3", "-O0", "-Wall", "-Wextra", "-std=c++17" }
        or { "-O2", "-DNDEBUG", "-Wall", "-Wextra", "-std=c++17" }
    return make_cmd("clang++", flags, file, out)
  end,

  rust = function(file, out, mode)
    local flags = mode == "debug" and { "-g" } or { "-O" }
    return make_cmd("rustc", flags, file, out)
  end,

  pascal = function(file, out, mode)
    local flags = mode == "debug" and { "-g", "-gl" } or { "-O3" }
    local cmd = { "fpc" }
    vim.list_extend(cmd, flags)
    table.insert(cmd, "-o" .. out)
    table.insert(cmd, file)
    return cmd
  end,
}

function M.can_compile(ft)
  ft = ft or vim.bo.filetype
  return compilers[ft] ~= nil
end

function M.compile(mode, build_dir)
  local ft = vim.bo.filetype
  local make = compilers[ft]
  if not make then
    return false, { "No single-file compiler for filetype: " .. ft }
  end

  local file = vim.fn.expand("%:p")
  if file == "" then
    return false, { "No file in current buffer" }
  end

  vim.fn.mkdir(build_dir, "p")
  local out = build_dir .. "/main"

  local cmd = make(file, out, mode)
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return false, output
  end
  return true, nil
end

return M
