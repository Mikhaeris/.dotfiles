return {
    "local/live-server",
    dir = vim.fn.stdpath("config") .. "/lua/custom_plugins/live-server",

    config = function(_, opts)
        require("custom_plugins.live-server").setup(opts)
    end,

    opts = {
        port = 3000,
        auto_open = true,
        -- command = { "browser-sync", "start", "--server", "--files", ".", "--no-notify", "--browser", "firefox", "--port" },
    },

    cmd = {
        "LiveServerStart",
        "LiveServerStop",
        "LiveServerToggle",
    },

    keys = {
        { "<leader>sl", "<cmd>LiveServerToggle<cr>", desc = "Live Server Toggle" },
    },
}
