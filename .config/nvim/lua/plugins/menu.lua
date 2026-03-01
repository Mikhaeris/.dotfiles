return {
	{
		"nvzone/volt",
		lazy = true,
	},
	{
		"nvzone/menu",
		lazy = true,
		keys = {
			{
				"<C-t>",
				function()
					require("menu").open("default")
				end,
				mode = "n",
				desc = "Open NVZone menu",
			},
		},
	},
}
