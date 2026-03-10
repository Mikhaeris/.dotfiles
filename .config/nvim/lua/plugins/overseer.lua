return {
	"stevearc/overseer.nvim",
	keys = {
		{ "<leader>oo", "<cmd>OverseerToggle!<CR>", mode = "n", desc = "[O]verseer [O]pen" },
		{ "<leader>or", "<cmd>OverseerRun<CR>", mode = "n", desc = "[O]verseer [R]un" },
		{ "<leader>os", "<cmd>OverseerShell<CR>", mode = "n", desc = "[O]verseer [S]hell" },
		{ "<leader>ot", "<cmd>OverseerTaskAction<CR>", mode = "n", desc = "[O]verseer [T]ask action" },
		{
			"<leader>of",
			function()
				local task = require("overseer").list_tasks({ recent_first = true })[1]
				if task then
					task:open_output("float")
				else
					vim.notify("no tasks running")
				end
			end,
			mode = "n",
			desc = "overseer float output",
		},
	},
	---@module 'overseer'
	---@type overseer.SetupOpts
	---
	opts = {
		-- strategy = "toggleterm",
		component_aliases = {
			-- default = {
			-- 	"on_exit_set_status",
			-- 	{ "on_complete_notify", system = "unfocused" },
			-- 	{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			-- },
		},
		output = {
			use_terminal = false,
		},
		task_list = {
			direction = "left",
			open_cmd = "vsplit",
			width = 20,
			show_detail = false,
		},
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		overseer.register_template({
			name = "cppcheck",
			builder = function()
				local targets = vim.split("main.c ./src", " ")
				return {
					cmd = "cppcheck",
					args = {
						"--enable=all",
						"--inline-suppr",
						"--template=gcc",
						"--suppress=missingIncludeSystem",
						targets,
					},
					cwd = vim.fn.getcwd(),
					components = { "default" },
				}
			end,
		})

		overseer.register_template({
			name = "valgrind",
			builder = function()
				local exe = "./build/debug/main"

				return {
					cmd = { "valgrind" },
					args = {
						"--leak-check=full",
						"--show-leak-kinds=all",
						"--track-origins=yes",
						"--error-exitcode=1",
						exe,
					},
					cwd = vim.fn.getcwd(),
					components = { "default" },
				}
			end,
		})
	end,
}
