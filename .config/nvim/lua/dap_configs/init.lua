local M = {}

local ft_to_module = {
  c          = "dap_configs.c",
  cpp        = "dap_configs.cpp",
  asm        = "dap_configs.assembler",
  nasm       = "dap_configs.assembler",
  pascal     = "dap_configs.pascal",
  python     = "dap_configs.python",
}

local loaded = {}

local function load_for_ft(ft)
  local mod = ft_to_module[ft]
  if not mod or loaded[mod] then
    return
  end

  local ok, err = pcall(require, mod)
  if ok then
    loaded[mod] = true
  else
    vim.notify(
      string.format("Failed to load DAP config for %s: %s", ft, err),
      vim.log.levels.WARN
    )
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("dap_configs_lazy", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = vim.tbl_keys(ft_to_module),
    callback = function(ev)
      load_for_ft(vim.bo[ev.buf].filetype)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "DapConfigLoad",
    callback = function()
      load_for_ft(vim.bo.filetype)
    end,
  })
end

return M
