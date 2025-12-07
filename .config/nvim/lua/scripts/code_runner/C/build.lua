local M = {}

local function run_job(cmd, cwd, on_complete)
  local out = {}
  local err = {}
  vim.fn.jobstart(cmd, {
    cwd = cwd,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, l in ipairs(data) do
          if l ~= "" then table.insert(out, l) end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, l in ipairs(data) do
          if l ~= "" then table.insert(err, l) end
        end
      end
    end,
    on_exit = function(_, code)
      local combined = {}
      for _, l in ipairs(err) do table.insert(combined, l) end
      for _, l in ipairs(out) do table.insert(combined, l) end
      if on_complete then on_complete(code, combined) end
    end,
  })
end

local function open_qf_if_errors(code, lines, title)
  if code ~= 0 and #lines > 0 then
    local items = {}
    for _, ln in ipairs(lines) do
      table.insert(items, {text = ln})
    end
    vim.fn.setqflist(items, ' ', {title = title})
    vim.cmd('botright copen 12')
  end
end

local function gather_sources(src_dir)
  local files = {}
  local handle = vim.loop.fs_scandir(src_dir)
  if handle then
    while true do
      local name, typ = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if typ == "file" and name:match("%.c$") then
        table.insert(files, src_dir .. "/" .. name)
      end
    end
  end
  return files
end

function M.build_project(build_dir, build_type, on_finish)
  build_type = build_type or "Debug"
  build_dir = build_dir or ("build/" .. build_type:lower())
  vim.fn.mkdir(build_dir, "p")
  local output = build_dir .. "/main"

  local src_dir = "./"
  local sources = gather_sources(src_dir)
  if #sources == 0 then
    print("No .c files found in " .. src_dir)
    if on_finish then on_finish(1) end
    return
  end

  local cflags = {"-Wall", "-Wextra"}
  if build_type == "Debug" then
    table.insert(cflags, "-g")
  elseif build_type == "Release" then
    table.insert(cflags, "-O2")
  end

  local cmd = {"gcc"}
  for _, f in ipairs(cflags) do table.insert(cmd, f) end
  for _, f in ipairs(sources) do table.insert(cmd, vim.fn.fnamemodify(f, ":p")) end
  table.insert(cmd, "-o")
  table.insert(cmd, vim.fn.fnamemodify(output, ":p"))

  print("Building " .. build_type .. " -> " .. output)
  run_job(cmd, src_dir, function(code, lines)
    print(vim.inspect(lines))
    open_qf_if_errors(code, lines, "GCC Build: " .. build_type)
    if code == 0 then
      print("Build succeeded: " .. output)
    else
      print("Build failed!")
    end
    if on_finish then on_finish(code) end
  end)
end

return M
