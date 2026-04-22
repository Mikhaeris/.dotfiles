return {
  "lewis6991/gitsigns.nvim",
  enabled = false,
  event = "BufReadPre",
  opts = {
    signs = { add = { text = "▎" }, change = { text = "▎" }, delete = { text = "" } },
    on_attach = function(buf)
      local gs = package.loaded.gitsigns
      vim.keymap.set("n", "]h", gs.next_hunk, { buffer = buf, desc = "Next hunk" })
      vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = buf, desc = "Prev hunk" })
      vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = buf, desc = "Preview hunk" })
      vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = buf, desc = "Blame line" })
    end,
  },
}
