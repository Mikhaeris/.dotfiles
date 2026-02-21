local M = {}

local state = {
	job_id = nil,
	config = {
		port = 3000,
		command = { "browser-sync", "start", "--server", "--files", ".", "--no-notify", "--port" },
		auto_open = true,
	},
}

function M.stop()
	if state.job_id then
		vim.fn.jobstop(state.job_id)
		state.job_id = nil
		vim.notify("󰓛 Browser-sync stopped", vim.log.levels.WARN)
	end
end

function M.start()
	if state.job_id then
		M.stop()
	end

	local cmd = vim.deepcopy(state.config.command)
	table.insert(cmd, tostring(state.config.port))

	state.job_id = vim.fn.jobstart(cmd, {
		cwd = vim.loop.cwd(),
		detach = true,
		on_exit = function()
			state.job_id = nil
		end,
	})

	if state.job_id > 0 then
		local url = "http://localhost:" .. state.config.port
		vim.notify("󰄭 Browser-sync started on " .. url, vim.log.levels.INFO)

		if state.config.auto_open and not state.browser_opened then
			vim.ui.open(url)
			state.browser_opened = true
		end
	else
		vim.notify("Failed to start browser-sync", vim.log.levels.ERROR)
	end
end

function M.toggle()
	if state.job_id then
		M.stop()
	else
		M.start()
	end
end

function M.setup(opts)
	state.config = vim.tbl_deep_extend("force", state.config, opts or {})

	vim.api.nvim_create_user_command("LiveServerStart", M.start, { desc = "Start Browser-sync" })
	vim.api.nvim_create_user_command("LiveServerStop", M.stop, { desc = "Stop Browser-sync" })
	vim.api.nvim_create_user_command("LiveServerToggle", M.toggle, { desc = "Toggle Browser-sync" })

	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = M.stop,
	})
end

return M
