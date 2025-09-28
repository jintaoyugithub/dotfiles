return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },

    config = function()
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 999
        vim.o.foldlevelstart = 999
        vim.o.foldenable = true

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end,

            keys = {
                { "zR", function() require('ufo').openAllFolds() end,  desc = "Open all folds" },
                { "zM", function() require('ufo').closeAllFolds() end, desc = "Close all folds" },
            },
        })
    end
}
