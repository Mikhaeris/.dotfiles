return {
	"aikhe/wrapped.nvim",
	dependencies = { "nvzone/volt" },
	cmd = { "NvimWrapped" },
	opts = {
		config_path = vim.fn.stdpath("config"),
	},
}
