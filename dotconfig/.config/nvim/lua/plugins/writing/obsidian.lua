return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },

    keys = {
        { "<leader>oo", "<cmd>ObsidianOpen<cr>",                   desc = "Open the notes in Obsidian" },
        { "<leader>on", ":ObsidianNew ",                           desc = "Create a new note" },
        { "<leader>os", "<cmd>ObsidianSearch<cr>",                 desc = "Search Obsidian" },
        { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>",            desc = "Obsidian Find Files" },
        { "<leader>og", "<cmd>ObsidianTags<cr>",                   desc = "a picker list of all occurrences of the given tags" },
        { "<leader>op", "<cmd>ObsidianPasteImg<cr>",               desc = "Obsidian Paste Image" },
        { "<leader>or", "<cmd>ObsidianRename<cr>",                 desc = "Obsidian Rename current note" },
        { "<leader>oi", "<cmd>ObsidianTemplate<cr>",               desc = "Insert Obsidian Template into file" },
        { "<leader>oe", "<cmd>ObsidianExtracNote<cr>",             desc = "extract the visually selected text into a new note and link to it" },
        { "<leader>od", "<cmd>ObsidianDailies<cr>",                desc = "a picker display daily-notes" },
        { "<leader>ot", "<cmd>ObsidianToday<cr>",                  desc = "open/create a daily note" },
        -- For obsidian review mode
        { "<leader>ok", ":!mv '%:p' ~/vaults/verified<cr>:bd<cr>", desc = "move the file to verified folder" },
        { "<leader>no", ":!rm '%:p'<cr>:bd<cr>",                   desc = "delete the file" },
        { "<leader>rt", "0wdf_",                                   desc = "remove the date of the title" },
        -- { "<leader>cn", "0f]hxi~<esc>",                            desc = "checkbox no" },
        -- { "<leader>cf", "0f]hxi><esc>",                            desc = "checkbox follow" },
    },

    config = function()
        -- Custom functions
        -- 1. Auto generate id for choosen blocks
        local function generate_id()
            local chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
            local id = ''
            math.randomseed(os.time())
            for i = 1, 6 do
                local index = math.random(#chars)
                id = id .. chars:sub(index, index)
            end
            return ' ^' .. id
        end

        local function append_id_to_selection()
            -- Get the current buffer and the selection range
            local bufnr = vim.api.nvim_get_current_buf()
            local start_pos = vim.api.nvim_buf_get_mark(bufnr, '<')
            local end_pos = vim.api.nvim_buf_get_mark(bufnr, '>')

            -- Get the content of the selected lines
            local selected_lines = vim.api.nvim_buf_get_lines(bufnr, start_pos[1] - 1, end_pos[1], false)

            -- Generate the ID
            local id = generate_id()

            -- If only one line is selected, append the ID to the end of that line
            if #selected_lines == 1 then
                local line = selected_lines[1]
                -- Append the ID at the end of the line
                vim.api.nvim_buf_set_text(bufnr, start_pos[1] - 1, #line, start_pos[1] - 1, #line, { id })
            else
                -- If multiple lines are selected, append the ID to the end of the last line
                vim.api.nvim_buf_set_text(bufnr, end_pos[1] - 1, #selected_lines[#selected_lines], end_pos[1] - 1,
                    #selected_lines[#selected_lines], { id })
            end
        end

        -- Custom commands
        vim.api.nvim_create_user_command('AddID', append_id_to_selection, { range = true })

        require("obsidian").setup {
            ui = { enable = true },
            -- Set up the vaults directory
            dir = "$HOME/vaults/",
            notes_subdir = "inbox",

            -- Optional, customize how note IDs are generated given an optional title.
            ---@param title string|?
            ---@return string
            note_id_func = function(title)
                -- Get the current date in 'YYYY-MM-DD' format
                local date_suffix = os.date("%Y-%m-%d")
                local id = ""

                if title ~= nil then
                    -- If title is given, transform it into a valid file name prefix.
                    id = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower() .. "_" .. date_suffix
                else
                    -- If title is nil, just add 4 random uppercase letters as the prefix.
                    for _ = 1, 4 do
                        id = id .. string.char(math.random(65, 90))
                    end
                end

                -- Return the final ID as 'title_YYYY-MM-DD'
                return id
            end,

            -- Optional, customize how note file names are generated given the ID, target directory, and title.
            ---@param spec { id: string, dir: obsidian.Path, title: string|? }
            ---@return string|obsidian.Path The full path to the new note.
            note_path_func = function(spec)
                -- Extract the title from the ID (everything before the last underscore)
                local title_part = spec.id:match("^(.*)_%d%d%d%d%-%d%d%-%d%d$")

                -- If title is nil, fallback to using the ID directly
                local filename = (title_part or spec.id) .. "_" .. os.date("%Y-%m-%d")

                -- Return the full file path with ".md" extension
                local path = spec.dir / filename
                return path:with_suffix(".md")
            end,

            -- Set up completion
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,
                -- Trigger completion at 1 chars.
                min_chars = 1,
            },
            -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
            -- way then set 'mappings = {}'.
            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ["<leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
                -- Smart action depending on context, either follow link or toggle checkbox.
                ["<cr>"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                }
            },

            -- Optional, boolean or a function that takes a filename and returns a boolean.
            -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
            disable_frontmatter = true,

            -- Optional, alternatively you can customize the frontmatter data.
            ---@return table
            note_frontmatter_func = function(note)
                -- Add the title of the note as an alias.
                -- if note.title then
                --     note:add_alias(note.title)
                -- end

                local out = {
                    id = note.id,
                    tags = note.tags,
                    date = os.date("%Y-%m-%d"),
                }

                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end

                return out
            end,

            -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
            open_app_foreground = true,

            -- Optional, for templates (see below).
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- A map for custom variables, the key should be the variable and the value a function
                substitutions = {
                    week_start = function()
                        local week_ago = os.time() - (7 * 24 * 60 * 60)
                        return os.date("%Y-%m-%d", week_ago)
                    end,
                    month = function()
                        return os.date("%m")
                    end,
                    year = function()
                        return os.date("%Y")
                    end,
                    day = function()
                        return os.date("%d")
                    end,
                    compute_wakeup = function()
                        -- assume I spent 30 mins on breakfast and other things
                        local wakeup = os.time() - (30 * 60)
                        return os.date("%H:%M", wakeup)
                    end
                },
            },

            -- Where to put new notes. Valid options are
            --  * "current_dir" - put new notes in same directory as the current buffer.
            --  * "notes_subdir" - put new notes in the default notes subdirectory.
            new_notes_location = "notes_subdir",

            daily_notes = {
                -- Optional, if you keep daily notes in a separate directory.
                folder = "notes/every-week",
                -- Optional, if you want to change the date format for the ID of daily notes.
                date_format = "%Y-%m-%d",
                -- Optional, if you want to change the date format of the default alias of daily notes.
                alias_format = "%B %-d, %Y",
                -- Optional, default tags to add to each new daily note created.
                default_tags = { "daily-notes" },
                -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
                template = "daily.md"
            },



            -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
            -- URL it will be ignored but you can customize this behavior here.
            ---@param url string
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
                -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
                -- vim.ui.open(url) -- need Neovim 0.10.0+
            end,

            -- Specify how to handle attachments.
            attachments = {
                -- The default folder to place images in via `:ObsidianPasteImg`.
                -- If this is a relative path it will be interpreted as relative to the vault root.
                -- You can always override this per image by passing a full path to the command instead of just a filename.
                img_folder = "assets/imgs", -- This is the default

                -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
                ---@return string
                img_name_func = function()
                    -- Prefix image names with timestamp.
                    return string.format("%s-", os.time())
                end,

                -- A function that determines the text to insert in the note when pasting an image.
                -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
                -- This is the default implementation.
                ---@param client obsidian.Client
                ---@param path obsidian.Path the absolute path to the image file
                ---@return string
                img_text_func = function(client, path)
                    path = client:vault_relative_path(path) or path
                    return string.format("![%s](%s)", path.name, path)
                end,
            },
        }
    end
}
