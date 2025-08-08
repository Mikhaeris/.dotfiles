return {
  {
    "echasnovski/mini.bufremove",
    config = function()
      require("mini.bufremove").setup()
      vim.keymap.set("n", "<leader>c", function()
        require("mini.bufremove").delete(0, false)
      end)
    end,
  },
}
