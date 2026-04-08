-- Window set
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-j>", ":wimcmd j<CR>")
vim.keymap.set("n", "<c-k>", ":wimcmd k<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Copy text
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, silent = true })

-- Select all
vim.keymap.set("n", "<leader>a", "ggVG")

-- Change directory
vim.keymap.set("n", "<leader>gc", ":cd %:p:h<CR>", { silent = true })

-- incremental selection treesitter/lsp
local function ts_or_lsp(count)
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(count)
  else
    vim.lsp.buf.selection_range(count)
  end
end

vim.keymap.set({ "n", "x" }, "<C-g>", function() ts_or_lsp(1) end,
  { desc = "TS: init / select parent node" })

vim.keymap.set({ "n", "x" }, "<C-k>", function() ts_or_lsp(vim.v.count1) end,
  { desc = "TS: select parent node" })

vim.keymap.set("x", "<C-j>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "TS: select child node" })
