local modules = {
  "dap_configs.configs.assembler",
  "dap_configs.configs.c",
  "dap_configs.configs.cpp",
  "dap_configs.configs.python",
}

for _, m in ipairs(modules) do
  pcall(require, m)
end
