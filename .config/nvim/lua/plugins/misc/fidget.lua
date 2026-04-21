return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        -- notification = {
        --     redirect = function(msg, level, opts)
        --         return require("snacks").notify(msg, level, opts)
        --     end,
        -- },
        progress = {
            display = {
                done_ttl = 1,
                progress_ttl = 8,
            },
        },
    },
}
