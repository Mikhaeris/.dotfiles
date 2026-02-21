local server = {
  pid = nil,
  port = 8000
}

local function stop_server()
  if server.pid then
    os.execute("kill -9 " .. server.pid)
    server.pid = nil
    print("Server stopped!")
  end
end

local function start_server()
  if server.pid then
    stop_server()
    return
  end

  local job_id = vim.fn.jobstart({"python3", "-m", "http.server", tostring(server.port)}, {
    cwd = vim.loop.cwd(),
    detach = true,
  })
  server.pid = job_id

  local open_cmd = "gio open http://localhost:"..server.port

  if open_cmd then
    vim.fn.system(open_cmd)
  end

  print("Server run on port "..server.port)
end

-- auto stop if nvim closes
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    stop_server()
  end
})

vim.api.nvim_create_user_command(
  "LiveServerStart",
  function()
    start_server()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "LiveServerStop",
  function()
    stop_server()
  end,
  {}
)
