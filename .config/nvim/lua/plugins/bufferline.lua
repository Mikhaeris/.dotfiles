return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = {
		options = {
			mode = "buffers",
			-- separator_style = "thin",
			diagnostics = "nvim_lsp",
			offsets = {
				{
					filetype = "neo-tree",
					text = "  File Explorer",
					text_align = "center",
					highlight = "Directory",
					separator = false,
				},
			},
		},
		highlights = function()
			local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
			vim.api.nvim_set_hl(0, "BufferLineFill", { bg = normal_bg })
		end,
	},
	keys = {
		{ "<Tab>", "<cmd>BufferLineCycleNext<CR>", mode = "n", silent = true },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", mode = "n", silent = true },
		-- { "<leader>c", "<cmd>bd<CR>", mode = "n", silent = true },
	},
}
