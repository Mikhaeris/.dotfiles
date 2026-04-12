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

    map("n", "<leader>q", function()
      vim.diagnostic.setloclist({
        open = true,
        severity = { min = sev.WARN },
      })
    end, vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))
  end,
})
