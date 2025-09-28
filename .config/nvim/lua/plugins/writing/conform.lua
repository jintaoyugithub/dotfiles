return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup {
            -- Set up the formatter for each language --
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang_format" },
                cmake = { "cmake_format" },
                markdown = { "mdformat" },
            },

            formatters = {
                clang_format = {
                    command = "clang-format",
                    args = { "--style=Microsoft" },
                },
                cmakeformat = {
                    command = "cmake_format",
                    args = { "--style=Microsoft" },
                },
            },

            -- Auto format on save --
            format_on_save = {
                -- I recommend these options. See :help conform.format for details.
                lsp_format = "fallback",
                timeout_ms = 500,
            },
        }
    end
}
