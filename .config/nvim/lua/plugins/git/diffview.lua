return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
		"DiffviewFileHistory",
	},
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>",       desc = "Diffview Open" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview File History" },
	},
}
