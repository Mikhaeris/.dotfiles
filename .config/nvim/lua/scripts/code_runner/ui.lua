local M = {}

function M.show_errors(lines)
	vim.cmd("botright 10split")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_win_set_buf(0, buf)
	vim.opt_local.wrap = true
	vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true })
end

function M.run_in_terminal(cmd)
	-- Close old terminals
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end

  local term_cmd = string.format('printf "\\n--- Program output ---\\n\\n" && %s', cmd)
	-- vim.cmd("vertical rightbelow split")
  vim.cmd("rightbelow vsplit")
  vim.cmd("vertical resize 50")

	vim.cmd("terminal " .. term_cmd)
	vim.cmd("startinsert")
end

-- for now time, need to modify in future
function M.run_dap(exe, args_str)
	local dap = require("dap")
  dap.run({
    name = "Debug Build",
    type = "codelldb",
    request = "launch",
    program = exe,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = vim.split(args_str, "%s+"),
  })
end

return M
