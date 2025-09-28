return {
    "neovim/nvim-lspconfig",
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup {
            init_options = {
                fallbackFlags = {
                    '--std=c++11'
                },
            },

            capabilities = capabilities,
        }
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
        }
        lspconfig.cmake.setup {
            capabilities = capabilities,
        }
    end,
}
