return {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = "auto", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true,

            -- darken the unuse window --
            dim_inactive = {
                enabled = false, -- dims the background color of inactive window
                shade = "light",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
         }
        -- load the colorscheme
        vim.cmd.colorscheme("catppuccin-mocha")
    end
}
