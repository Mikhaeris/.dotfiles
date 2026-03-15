return {
	{
		"echasnovski/mini.bufremove",
		config = function()
			require("mini.bufremove").setup()
			vim.keymap.set("n", "<leader>ct", function()
				require("mini.bufremove").delete(0, false)
			end)
		end,
	},
	{
		"echasnovski/mini.align",
		config = function()
			require("mini.align").setup()
		end,
	},
}
