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
}
