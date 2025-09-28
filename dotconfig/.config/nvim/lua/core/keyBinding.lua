-- set up the leader key
vim.g.mapleader = " "

-- Key mappings
local mappings = {
    J = '5j',
    K = '5k',
    H = '5h',
    L = '5l',
}
for key, cmd in pairs(mappings) do
    vim.api.nvim_set_keymap('n', key, cmd, { noremap = true })
    vim.api.nvim_set_keymap('v', key, cmd, { noremap = true })
end
vim.api.nvim_set_keymap('n', 'vv', '<c-v>', { noremap = true })
vim.api.nvim_set_keymap('n', 'Y', '"+y', { noremap = true })

-- Save/exit/refresh files
vim.api.nvim_set_keymap('n', 's', '<nop>', {})
vim.api.nvim_set_keymap('n', 'W', ':w<CR>', {})
vim.api.nvim_set_keymap('n', 'Q', ':q<CR>', {})
vim.api.nvim_set_keymap('n', 'Z', ':nohlsearch<CR>', {})
vim.api.nvim_set_keymap('n', 'X', ':x<CR>', {})
vim.api.nvim_set_keymap('n', 'R', ':w<CR>:source $MYVIMRC<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>q', ':qa<CR>', {})

-- Spell check
-- vim.api.nvim_set_keymap('n', '<leader>sc', ':set spell!<CR>', {})
vim.api.nvim_set_keymap('n', '<C-x>', 'ea<C-x>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-x>', '<Esc>ea<C-x>s', { noremap = true })

-- Split windows settings
vim.api.nvim_set_keymap('n', 'sh', ':set nosplitright<CR>:vsplit<CR>', {})
vim.api.nvim_set_keymap('n', 'sl', ':set splitright<CR>:vsplit<CR>', {})
vim.api.nvim_set_keymap('n', 'sj', ':set splitbelow<CR>:split<CR>', {})
vim.api.nvim_set_keymap('n', 'sk', ':set nosplitbelow<CR>:split<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>sn', ':vsp<space>', {})

-- Move cursor between windows
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {})
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {})

-- Tabs
vim.api.nvim_set_keymap('n', '<leader>nt', ':tabe<CR>', {})

-- Toggle Table Mode
vim.api.nvim_set_keymap('n', '<leader>tm', ':TableModeToggle<CR>', { noremap = true })

-- Comment
vim.api.nvim_set_keymap('v', '/', 'gc', {})

-- Markdown settings
vim.api.nvim_command('autocmd FileType markdown inoremap ,d ---<Enter><Enter>')
vim.api.nvim_command('autocmd FileType markdown inoremap ,b **** <++><Esc>F*hi')
vim.api.nvim_command('autocmd FileType markdown inoremap ,s ~~~~ <++><Esc>F~hi')
vim.api.nvim_command('autocmd FileType markdown inoremap ,i ** <++><Esc>F*i')
vim.api.nvim_command('autocmd FileType markdown inoremap ,h `` <++><Esc>F`i')
vim.api.nvim_command('autocmd FileType markdown inoremap ,c ``````<Enter><++><Esc>1k03l')
vim.api.nvim_command('autocmd FileType markdown inoremap ,p ![](<++>) <Esc>F[a')
vim.api.nvim_command('autocmd FileType markdown inoremap ,l [](<++>) <Esc>F[a')
vim.api.nvim_command('autocmd FileType markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l')
vim.api.nvim_command('autocmd FileType markdown inoremap ,m {% katex %}{% endkatex %} <Esc>F{i')
vim.api.nvim_command('autocmd FileType markdown inoremap ,k <CR>{% katex %}<CR>{% endkatex %} <Esc>F{O')

-- lsp key mapping --
vim.api.nvim_set_keymap('n', '<leader>gD', ':lua vim.lsp.buf.declaration()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gd', ':lua vim.lsp.buf.definition()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gh', ':lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gi', ':lua vim.lsp.buf.implementation()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gs', ':lua vim.lsp.buf.signature_help()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>gt', ':lua vim.lsp.buf.type_definition()<CR>', {})

-- display the error
vim.api.nvim_set_keymap('n', '<leader>ed', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>en', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ep', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
