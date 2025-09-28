return {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
        -- add options here
        -- or leave it empty to use the default settings

        -- specific for obsidian project
        dirs = {
            ["$HOME/vaults/"] = {
                -- default dir is assets/dir_path
                dir_path = "imgs/"
            },
        },
    },

    default = {
    },

    keys = {
        -- suggested keymap
        { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
}
