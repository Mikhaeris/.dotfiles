return {
	"DrKJeff16/project.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
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

		telescope = { enabled = true },
	},
	config = function(_, opts)
		require("project").setup(opts)

		local telescope = require("telescope")
		telescope.setup({
			extensions = {
				projects = {
					prompt_prefix = "󱎸 ",
					layout_strategy = "horizontal",
					layout_config = {
						anchor = "N",
						height = 0.25,
						width = 0.6,
						prompt_position = "bottom",
					},
				},
			},
		})
		telescope.load_extension("projects")

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
			vim.cmd("ProjectTelescope")
		end, { desc = "Projects: picker & activate sessions" })

		-- Force active session for this directory
		vim.keymap.set("n", "<leader>pr", function()
			session_active = true
			resession.load(vim.fn.getcwd(), { dir = "dirsession", reset = true })
		end, { desc = "Projects: force load session here" })

		vim.keymap.set("n", "<leader>ps", "<cmd>ProjectRecents<cr>", { desc = "Projects: recents" })
		-- vim.keymap.set("n", "<leader>pc", "<cmd>ProjectRoot<cr>", { desc = "Projects: root" })
	end,
}
