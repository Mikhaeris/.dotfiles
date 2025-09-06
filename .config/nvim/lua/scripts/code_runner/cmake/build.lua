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
        for _, l in ipairs(data) do if l ~= "" then table.insert(out, l) end end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, l in ipairs(data) do if l ~= "" then table.insert(err, l) end end
      end
    end,
    on_exit = function(_, code)
      local combined = {}
      for _, l in ipairs(err) do table.insert(combined, l) end
      for _, l in ipairs(out) do table.insert(combined, l) end
      on_complete(code, combined)
    end,
  })
end

local function open_qf_if_errors(code, lines, title)
  if code ~= 0 then
    local items = {}
    for _, ln in ipairs(lines) do table.insert(items, {text = ln}) end
    vim.fn.setqflist({}, ' ', {title = title, lines = items})
    vim.cmd('botright copen 12')
  end
end

function M.configure_and_build(build_dir, build_type, on_finish)
  build_dir = build_dir or ("build/" .. build_type:lower())
  vim.fn.mkdir(build_dir, "p")

  local cfg_cmd = {"cmake", "-S", ".", "-B", build_dir, "-DCMAKE_BUILD_TYPE=" .. build_type}
  run_job(cfg_cmd, vim.fn.getcwd(), function(cfg_code, cfg_lines)
    open_qf_if_errors(cfg_code, cfg_lines, "CMake Configure: " .. build_type)
    if cfg_code ~= 0 then
      if on_finish then on_finish(0) end
      return
    end

    local build_cmd = {"cmake", "--build", build_dir, "--config", build_type, "--", "-j"}
    run_job(build_cmd, vim.fn.getcwd(), function(b_code, b_lines)
      open_qf_if_errors(b_code, b_lines, "CMake Build: " .. build_type)
      if on_finish then
          on_finish(b_code)
      end
    end)
  end)
end

return M
