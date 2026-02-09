return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0

		vim.g.vimtex_compiler_clean_on_terminate = 1

		vim.g.vimtex_compiler_latexmk_engines = {
			_ = "-xelatex",
		}

		vim.g.vimtex_compiler_latexmk = {
			out_dir = "build",
			executable = "latexmk",
			options = {
				"-pdfxe",
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
	end,
}
