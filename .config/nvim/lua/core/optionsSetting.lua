vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.clipboard = "unnamedplus"

-- make sure the cursor is in the middle of the screen
vim.opt.scrolloff = 999

-- treat the entire screen as a set of cells
vim.opt.virtualedit = "block"

-- preview the real time change of substitution
vim.opt.inccommand = "split"

-- ignore the casing problem for build-in and external command
vim.opt.ignorecase = true

-- enable a wider variety of colors
vim.opt.termguicolors = true

-- Encoding format --
vim.opt.encoding = "utf-8"

-- Font
vim.opt.guifont = "JetBrains Mono"

-- UI display level
vim.opt.conceallevel = 3


-- Remain the cursor position of last time --
local t_SR = "\27]50;CursorShape=2\7"
local t_EI = "\27]50;CursorShape=0\7"

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local last_position = vim.fn.line("'\"")
        if last_position > 1 and last_position <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
})

vim.diagnostic.config({ virtual_text = false });

-- Treesitter fold setting
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.opt.foldmethod = 'expr'
