vim.loader.enable()

require("core")

require("lazy").setup(require("plugins"), {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"zip",
				"zipPlugin",
				"tar",
				"tarPlugin",
				"getscript",
				"getscriptPlugin",
				"vimball",
				"vimballPlugin",
				"2html_plugin",
				"logiPat",
				"matchit",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"spellfile_plugin",
				"tutor",
			},
		},
	},
})
