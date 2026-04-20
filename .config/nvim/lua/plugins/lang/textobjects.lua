return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local sel = require("nvim-treesitter-textobjects.select").select_textobject
		local mov = require("nvim-treesitter-textobjects.move")

		-- selection
		vim.keymap.set({ "x", "o" }, "af", function()
			sel("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "if", function()
			sel("@function.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ac", function()
			sel("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ic", function()
			sel("@class.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "ai", function()
			sel("@conditional.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ii", function()
			sel("@conditional.inner", "textobjects")
		end)

		vim.keymap.set({ "x", "o" }, "al", function()
			sel("@loop.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "il", function()
			sel("@loop.inner", "textobjects")
		end)

		-- jump between objects
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			mov.goto_next_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			mov.goto_previous_start("@function.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			mov.goto_next_start("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			mov.goto_previous_start("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]i", function()
			mov.goto_next_start("@conditional.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[i", function()
			mov.goto_previous_start("@conditional.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]l", function()
			mov.goto_next_start("@loop.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[l", function()
			mov.goto_previous_start("@loop.outer", "textobjects")
		end)
	end,
}
