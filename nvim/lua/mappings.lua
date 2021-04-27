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

map('n', '<leader>pv', ':wincmd v<bar> :Ex <bar> :vertical resize 25<cr>')
map('n', '<leader>+', ':vertical resize +5<cr>')
map('n', '<leader>-', ':vertical resize -5<cr>')

-- move lines up/down using Alt+k / Alt+j
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")
