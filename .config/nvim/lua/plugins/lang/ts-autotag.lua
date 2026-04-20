return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	config = function()
		require("nvim-ts-autotag").setup()
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
