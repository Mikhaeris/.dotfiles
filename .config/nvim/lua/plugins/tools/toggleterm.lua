return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 80,
		open_mapping = false,
		shade_terminals = false,
		close_on_exit = false,

		persist_size = true,
		persist_mode = true,

		direction = "vertical",

		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},

	config = function(_, opts)
		require("toggleterm").setup(opts)

		local Terminal = require("toggleterm.terminal").Terminal

		local float_term = Terminal:new({
			direction = "float",
			hidden = true,
		})

		function _FLOAT_TOGGLE()
			float_term:toggle()
		end

		vim.keymap.set("n", "<leader>tf", _FLOAT_TOGGLE, { desc = "Float terminal" })

		local right_term = Terminal:new({
			direction = "vertical",
			size = 80,
			hidden = true,
		})

		function _RIGHT_TOGGLE()
			right_term:toggle()
		end

		vim.keymap.set("n", "<leader>tv", _RIGHT_TOGGLE, { desc = "Vertical terminal" })

		local dev_term = Terminal:new({
			cmd = "npm run dev",
			direction = "vertical",
			hidden = true,
		})

		function _DEV_TOGGLE()
			dev_term:toggle()
		end

		vim.keymap.set("n", "<leader>td", _DEV_TOGGLE, { desc = "Dev server" })


		local terms = {
			Terminal:new({ direction = "float" }),
			Terminal:new({ direction = "vertical" }),
			Terminal:new({ direction = "horizontal" }),
		}

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
