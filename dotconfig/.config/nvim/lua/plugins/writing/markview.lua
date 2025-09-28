-- For `plugins/markview.lua` users.
return {
    "OXY2DEV/markview.nvim",
    lazy = false,

    config = function()
        require("markview").setup({
            typst = {
                enable = false,

                codes = {},
                escapes = {},
                headings = {},
                labels = {},
                list_items = {},
                math_blocks = {},
                math_spans = {},
                raw_blocks = {},
                raw_spans = {},
                reference_links = {},
                subscripts = {},
                superscript = {},
                symbols = {},
                terms = {},
                url_links = {}
            },


            markdown = {
                headings = {
                    enable = true,

                    shift_width = 0,
                    org_indent = false,
                    org_indent_wrap = true,
                },
                list_items = {
                    enable = true,
                    wrap = false,

                    indent_size = 2,
                    shift_width = 4,

                    marker_minus = {
                        add_padding = false,
                        conceal_on_checkboxes = true,

                        text = "",
                        hl = "MarkviewListItemMinus"
                    },

                    marker_plus = {
                        add_padding = false,
                        conceal_on_checkboxes = true,

                        text = "",
                        hl = "MarkviewListItemPlus"
                    },

                    marker_star = {
                        add_padding = false,
                        conceal_on_checkboxes = true,

                        text = "",
                        hl = "MarkviewListItemStar"
                    },

                    marker_dot = {
                        add_padding = false,
                        conceal_on_checkboxes = true,
                    },

                    marker_parenthesis = {
                        add_padding = false,
                        conceal_on_checkboxes = true,
                    }
                },
            },

            preview = {
                icon_provider = "devicons",
            },

        })
    end

};
