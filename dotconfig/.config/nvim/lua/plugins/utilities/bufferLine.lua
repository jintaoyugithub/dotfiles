return {
    'akinsho/bufferline.nvim',

    version = "*",

    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },

    keys = {
        { "<leader>]",    ":BufferLineCycleNext<CR>", desc = "move to next buffer" },
        { "<leader>[",    ":BufferLineCyclePrev<CR>", desc = "move to prev buffer" },
        { "<leader><CR>", ":bd<CR>",                  desc = "clost a buffer" },
        { "<leader>pb",   ":BufferLinePick<CR>",      desc = "clost a buffer" },
        { "<leader>bp",   ":BufferLineTogglePin<CR>", desc = "clost a buffer" },
    },

    config = function()
        require("bufferline").setup {
            options = {
                offsets = {
                    {
                        filetype = "Neotree",
                        text = "File Explorer",
                        text_align = "left", -- 或者 "center" 或 "right"
                        separator = true
                    }
                },
            }
        }
    end
}
