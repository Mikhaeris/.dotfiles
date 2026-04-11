return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    vim.treesitter.language.register("nasm", "asm")

    -- incremental selection treesitter/lsp
    local function ts_or_lsp(count)
      if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_parent(count)
      else
        vim.lsp.buf.selection_range(count)
      end
    end

    vim.keymap.set({ "n", "x" }, "<C-g>", function()
      ts_or_lsp(1)
    end, { desc = "TS: init / select parent node" })

    vim.keymap.set({ "n", "x" }, "<C-k>", function()
      ts_or_lsp(vim.v.count1)
    end, { desc = "TS: select parent node" })

    vim.keymap.set("x", "<C-j>", function()
      if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_child(vim.v.count1)
      else
        vim.lsp.buf.selection_range(-vim.v.count1)
      end
    end, { desc = "TS: select child node" })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("ts_native", { clear = true }),
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        if ft == "latex" or ft == "tex" then
          return
        end
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}
