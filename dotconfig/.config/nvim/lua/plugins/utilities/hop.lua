return {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

        -- Key Bindings --
        vim.api.nvim_set_keymap('n', '<leader>h1', ':HopChar1<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>h2', ':HopChar2<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<leader>hw', ':HopWord<CR>', { noremap = true })
    end
}
