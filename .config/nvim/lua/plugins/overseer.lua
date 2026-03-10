return {
	"stevearc/overseer.nvim",
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {
		output = {
			use_terminal = false,
		},
		task_list = {
			direction = "left",
			open_cmd = "vsplit",
			width = 40,
			show_detail = false,
		},
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		overseer.register_template({
			name = "Hello Task",
			builder = function()
				return {
					cmd = { "echo", "Hello Overseer!" },
					components = { "default" },
				}
			end,
		})
	end,
}
