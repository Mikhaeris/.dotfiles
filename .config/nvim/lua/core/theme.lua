-- "vague" | "catppuccin"
vim.g.my_theme = vim.g.my_theme or "catppuccin"

local M = {}

local schemes = {
  vague      = "vague",
  catppuccin = "catppuccin-macchiato",
}

local function apply(name)
  local scheme = schemes[name]
  if not scheme then
    vim.notify("Unknown theme: " .. tostring(name), vim.log.levels.ERROR)
    return
  end
  vim.cmd.colorscheme(scheme)
end

function M.current()
  return vim.g.my_theme
end

function M.is_mono()
  return vim.g.my_theme == "vague"
end

vim.api.nvim_create_user_command("ThemeToggle", function()
  vim.g.my_theme = (vim.g.my_theme == "vague") and "catppuccin" or "vague"
  apply(vim.g.my_theme)
  vim.notify("Theme: " .. vim.g.my_theme, vim.log.levels.INFO, { title = "theme" })
end, { desc = "Toggle theme: vague ↔ catppuccin" })

vim.api.nvim_create_user_command("ThemeSet", function(args)
  if not schemes[args.args] then
    vim.notify("Unknown theme: " .. args.args, vim.log.levels.ERROR)
    return
  end
  vim.g.my_theme = args.args
  apply(args.args)
  vim.notify("Theme: " .. args.args, vim.log.levels.INFO, { title = "theme" })
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_keys(schemes)
  end,
  desc = "Set theme by name",
})

vim.keymap.set("n", "<leader>ut", "<cmd>ThemeToggle<cr>", { desc = "Toggle theme" })

return M
