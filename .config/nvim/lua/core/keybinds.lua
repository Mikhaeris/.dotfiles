-- Window set
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-j>", ":wimcmd j<CR>")
vim.keymap.set("n", "<c-k>", ":wimcmd k<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Copy text
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, silent = true })

require("scripts.build_and_run")
