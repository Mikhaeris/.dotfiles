return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<leader>fe",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"<leader>fc",
			"<cmd>Yazi cwd<cr>",
			desc = "Open yazi in nvim's working directory",
		},
	},
	opts = {
		open_for_directories = false,
	},
}
