return {
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Close current buffer",
			},
		},
		config = function()
			require("mini.bufremove").setup()
		end,
	},
	{
		"echasnovski/mini.align",
		keys = {
			{ "ga", mode = { "n", "x" }, desc = "Align" },
			{ "gA", mode = { "n", "x" }, desc = "Align (preview)" },
		},
		config = function()
			require("mini.align").setup()
		end,
	},
}
