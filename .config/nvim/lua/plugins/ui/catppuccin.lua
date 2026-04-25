return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "macchiato",
    background = { dark = "macchiato", light = "latte" },
    transparent_background = false,
    term_colors = true,
    integrations = {
      treesitter = true,
      treesitter_context = true,
      blink_cmp = true,
      which_key = true,
      neotree = true,
      bufferline = true,
      mini = { enabled = true },
      dap = true,
      dap_ui = true,
      indent_blankline = { enabled = true, scope_color = "lavender" },
      flash = true,
      fidget = true,
      markdown = true,
      semantic_tokens = true,
      lsp_trouble = true,
      illuminate = { enabled = true, lsp = true },
      snacks = { enabled = true, indent_scope_color = "lavender" },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints  = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints  = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
        inlay_hints = { background = true },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    if vim.g.my_theme == "catppuccin" then
      vim.cmd.colorscheme("catppuccin-macchiato")
    end
  end,
}
