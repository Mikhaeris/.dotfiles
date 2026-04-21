return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local themes = require("telescope.themes")

			telescope.setup({
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = true,
					},
					live_grep = {
						additional_args = function()
							return { "--hidden", "--no-ignore" }
						end,
					},
				},

				extensions = {
					["ui-select"] = themes.get_dropdown({}),
				},
			})
			telescope.load_extension("ui-select")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		end,
	},
}
