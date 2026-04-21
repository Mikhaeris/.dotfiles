return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		scroll = {},
		notifier = {
			enabled = true,
			timeout = 3000,
			style = "minimal",
			top_down = true,
		},
		dashboard = {
			preset = {
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{
						icon = " ",
						key = "n",
						desc = "New File",
						action = ":ene | startinsert",
					},
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = " ",
						key = "p",
						desc = "Open Project",
						action = "<cmd>ProjectTelescope<cr>",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{
						icon = " ",
						key = "W",
						desc = "Wrapped",
						action = ":NvimWrapped",
					},
					{
						icon = " ",
						key = "q",
						desc = "Quit",
						action = ":qa",
					},
				},
			},
		},
	},
}
