local M = {}

function M.compile(cmd, mode, build_dir)
  -- Create directory if not exit
  vim.fn.mkdir(build_dir, "p")

  -- Run command build
  local full_cmd = string.format("%s %s %s", cmd, mode, build_dir)
  local output = vim.fn.systemlist(full_cmd)
  local exit_code = vim.v.shell_error


  if exit_code ~= 0 then
    return false, output
  end
    return true, nil
end

return M
