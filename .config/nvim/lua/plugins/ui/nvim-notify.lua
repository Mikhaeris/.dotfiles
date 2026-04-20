return {
  enabled = false,
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		vim.notify = notify
		notify.setup({
			-- stages = "fade_in_slide_out",
			timeout = 2000,
		})
	end,
}
