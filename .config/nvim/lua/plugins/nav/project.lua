return {
	"DrKJeff16/project.nvim",
	event = "VeryLazy",
	dependencies = {
		"ibhagwan/fzf-lua",
		"stevearc/resession.nvim",
	},
	opts = {
		detection_methods = {
			"lsp",
			"pattern",
		},
		patterns = {
			".git",
			"Makefile",
		},

		silent_chdir = true,
		scope_chdir = "global",
		enable_autochdir = false,

		snacks = {
			enabled = true,
			opts = {
				sort = "newest",
				hidden = false,
				title = "Select Project",
				layout = "select",
				-- icon {},
				-- path_icons = {},
			},
		},
	},
	config = function(_, opts)
		require("project").setup(opts)

		local resession = require("resession")

		local session_active = false

		-- Save before change project
		vim.api.nvim_create_autocmd("DirChangedPre", {
			callback = function()
				if session_active then
					resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
				end
			end,
		})

		-- Load seesion if directory changed
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				if session_active then
					resession.load(vim.fn.getcwd(), { dir = "dirsession", reset = true, silence_errors = true })
				end
			end,
		})

		-- Save in close
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				if session_active then
					resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
				end
			end,
		})

		vim.keymap.set("n", "<leader>pp", function()
			session_active = true
			vim.cmd("ProjectSnacks")
		end, { desc = "Projects: picker & activate sessions" })

		-- Force active session for this directory
		vim.keymap.set("n", "<leader>pr", function()
			session_active = true
			resession.load(vim.fn.getcwd(), { dir = "dirsession", reset = true })
		end, { desc = "Projects: force load session here" })

		-- vim.keymap.set("n", "<leader>ps", "<cmd>ProjectRecents<cr>", { desc = "Projects: recents" })
		-- vim.keymap.set("n", "<leader>pc", "<cmd>ProjectRoot<cr>", { desc = "Projects: root" })
	end,
}
