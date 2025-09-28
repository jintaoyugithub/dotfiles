-- with lazy.nvim
return {
    "LintaoAmons/bookmarks.nvim",
    -- pin the plugin at specific version for stability
    -- backup your bookmark sqlite db when there are breaking changes
    -- tag = "v2.3.0",
    dependencies = {
        { "kkharji/sqlite.lua" },
        { "nvim-telescope/telescope.nvim" },
        { "stevearc/dressing.nvim" } -- optional: better UI
    },
    config = function()
        local opts = {}                  -- go to the following link to see all the options in the deafult config file
        require("bookmarks").setup(opts) -- you must call setup to init sqlite db
        
        -- Key Bindings --
        vim.api.nvim_set_keymap('n', '<leader>bm', ':BookmarksMark<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>bs', ':BookmarksGoto<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>bl', ':BookmarksLists<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>bt', ':BookmarksTree<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>bd', ':BookmarksDesc<CR>', { noremap = true })
    end,
}

-- run :BookmarksInfo to see the running status of the plugin
