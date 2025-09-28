return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },

    keys = {
        { "<leader>cn", "wiNOTE: <Esc>", desc = "make current comment as note" },
        { "<leader>ch", "wiHACK: <Esc>", desc = "make current comment as hack" },
        { "<leader>ct", "wiTODO: <Esc>", desc = "make current comment as todo" },
        { "<leader>cf", "wiFIX: <Esc>",  desc = "make current comment as fix" },
        { "<leader>cw", "wiWARN: <Esc>", desc = "make current comment as warning" },
        { "<leader>cp", "wiPERF: <Esc>", desc = "make current comment as perfect" }
    },
}
