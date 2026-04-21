return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 500,
		icons = {
			mappings = false,
		},
		plugins = {
			marks = false,
			registers = false,
			spelling = {
				enabled = false,
			},
		},

		triggers = {
			{ "<leader>", mode = { "n", "v" } },
		},

		disable = {
			buftypes = {},
			filetypes = {},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Keymaps help",
		},
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>c", group = "Code" },
			{ "<leader>f", group = "Files" },
			{ "<leader>g", group = "Git" },
			{ "<leader>o", group = "Overseer" },
			{ "<leader>p", group = "Project" },
			{ "<leader>s", group = "Symbols" },
			{ "<leader>t", group = "Terminal" },
			{ "<leader>u", group = "Ui" },
			{ "<leader>tp", group = "Terminal presets" },
		})
	end,
}
