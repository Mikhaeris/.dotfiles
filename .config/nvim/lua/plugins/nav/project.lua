return {
	"DrKJeff16/project.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"stevearc/resession.nvim",
	},
	opts = {
		detection_methods = { "lsp", "pattern" },
		patterns = {
			".git",
			"Makefile",
		},
		silent_chdir = true,
		scope_chdir = "global",
		enable_autochdir = false,
		telescope = {
			enabled = true,
		},
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

		local is_startup = true
		local session_active = false

		vim.schedule(function()
			is_startup = false
		end)

		-- local function is_nvim_empty()
		-- 	if vim.fn.argc() > 0 then
		-- 		return false
		-- 	end
		-- 	local bufs = vim.api.nvim_list_bufs()
		-- 	if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
		-- 		return true
		-- 	end
		-- 	return false
		-- end

		-- Auto Load
		-- if nvim argc == 0 activate session for this directori
		-- if is_nvim_empty() then
		-- 	resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
		-- 	session_active = true
		-- end

		-- Save before change project
		vim.api.nvim_create_autocmd("DirChangedPre", {
			callback = function()
				-- Save only if session was active
				if not is_startup and session_active then
					resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
				end
			end,
		})

		-- Load seesion if directori changed
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				if is_startup then
					return
				end
				-- If Telescope change project - activate session
				resession.load(vim.fn.getcwd(), { dir = "dirsession", reset = true, silence_errors = true })
				session_active = true
			end,
		})

		-- Save in close
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				-- Save only if in session
				if session_active then
					resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
				end
			end,
		})

		vim.keymap.set("n", "<leader>pp", "<cmd>ProjectTelescope<cr>", { desc = "Projects: picker" })
		vim.keymap.set("n", "<leader>ps", "<cmd>ProjectRecents<cr>", { desc = "Projects: recents" })
		-- vim.keymap.set("n", "<leader>pc", "<cmd>ProjectRoot<cr>", { desc = "Projects: root" })

		-- Force active session for this directori
		vim.keymap.set("n", "<leader>pr", function()
			resession.load(vim.fn.getcwd(), { dir = "dirsession", reset = true })
			session_active = true
		end, { desc = "Projects: active & load session" })
	end,
}
