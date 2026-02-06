local M = {}

local function run_job(cmd, cwd, on_complete)
  local out, err = {}, {}

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
      vim.list_extend(combined, err)
      vim.list_extend(combined, out)
      if on_complete then on_complete(code, combined) end
    end,
  })
end

function M.build_project(build_dir, build_type, on_finish)
  build_type = build_type or "Debug"
  local cmd = {
    "./build.sh",
    build_type,
  }

  print("ASM build -> " .. build_type)

  run_job(cmd, vim.fn.getcwd(), function(code, lines)

    if code == 0 then
      print("Build succeeded")
    else
      print("Build failed")
    end

    if on_finish then on_finish(code) end
  end)
end

return M
