<leader>f → find (files, grep, buffers)
<leader>g → git
<leader>c → code (LSP)
<leader>b → buffers
<leader>p → project
<leader>t → terminal
<leader>s → search / select / symbol
<leader>u → UI / toggles


Config for nvim

To add new language:
1) LSP
    a) install Mason language server protocol (like lua_ls)
    b) set lspconfig
2) Formatting\syntax
    a) check Mason for formatter
    c) treesitter
4) DAP
    a) install dap in Mason
    b) create config in dap folder
    c) add require in debugger
