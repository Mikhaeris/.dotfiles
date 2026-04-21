return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = false,
	opts = {
		winopts = {
			height = 0.85,
			width = 0.80,
			preview = {
				layout = "vertical",
			},
		},
		files = {
			formatter = "path.filename_first",
		},
	},
	config = function()
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf Files" })
		vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf Live Grep" })
	end,
}
