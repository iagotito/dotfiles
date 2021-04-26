-----------------------------------------------------------------------------
-- Mappings
-----------------------------------------------------------------------------

vim.g.mapleader=' ' -- set `space` as leader key

map('n', '<leader>bn', '<cmd>bn<cr>')  -- buffer next
map('n', '<leader>l', '<cmd>noh<cr>')  -- clear highlights

-- windows navigation with leader instead of Ctrl
map('n', '<leader>wh', '<c-w>h')
map('n', '<leader>wj', '<c-w>j')
map('n', '<leader>wk', '<c-w>k')
map('n', '<leader>wl', '<c-w>l')
map('n', '<leader>ws', '<c-w>s')
map('n', '<leader>wv', '<c-w>v')
map('n', '<leader>w=', '<c-w>=')
