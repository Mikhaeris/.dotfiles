-- Window set
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<CR>", { silent = true, desc = "Window left" })
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<CR>", { silent = true, desc = "Window down" })
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<CR>", { silent = true, desc = "Window up" })
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<CR>", { silent = true, desc = "Window right" })

-- Copy text
-- vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true })
-- vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, silent = true })

-- Paste text without forget
vim.keymap.set("x", "<leader>bp", [["_dP]], { silent = true, desc = "Paste without forget" })

-- Select all
vim.keymap.set("n", "<leader>ba", "ggVG", { silent = true, desc = "Select all" })

-- Change directory to current file
-- vim.keymap.set("n", "<leader>pc", ":cd %:p:h<CR>", { silent = true, desc = "Change directoty" })

-- Keybindings for diagnostic
local map = vim.keymap.set
local sev = vim.diagnostic.severity

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    map("n", "]e", function()
      vim.diagnostic.jump({ count = 1, severity = sev.ERROR })
    end, vim.tbl_extend("force", opts, { desc = "Next error" }))

    map("n", "[e", function()
      vim.diagnostic.jump({ count = -1, severity = sev.ERROR })
    end, vim.tbl_extend("force", opts, { desc = "Prev error" }))

    map("n", "]w", function()
      vim.diagnostic.jump({ count = 1, severity = { min = sev.WARN } })
    end, vim.tbl_extend("force", opts, { desc = "Next warning or worse" }))

    map("n", "[w", function()
      vim.diagnostic.jump({ count = -1, severity = { min = sev.WARN } })
    end, vim.tbl_extend("force", opts, { desc = "Prev warning or worse" }))

    map("n", "gl", function()
      vim.diagnostic.open_float({
        scope = "cursor",
        border = "rounded",
        source = "if_many",
      })
    end, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))

    map("n", "<leader>dl", function()
      vim.diagnostic.setloclist({
        open = true,
        severity = { min = sev.WARN },
      })
    end, vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))
  end,
})

-- Move selected blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected blocks down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected blocks up" })
