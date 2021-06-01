-----------------------------------------------------------------------------
-- Mappings
-----------------------------------------------------------------------------

vim.g.mapleader=' ' -- set `space` as leader key

map('n', '<leader>bn', '<cmd>bn<cr>')  -- buffer next
map('n', '<leader>bp', '<cmd>bp<cr>')  -- buffer next
map('n', '<leader>l', '<cmd>noh<cr>')  -- clear highlights

-- windows navigation with leader instead of Ctrl
map('n', '<leader>wh', '<c-w>h')
map('n', '<leader>wj', '<c-w>j')
map('n', '<leader>wk', '<c-w>k')
map('n', '<leader>wl', '<c-w>l')
map('n', '<leader>ws', '<c-w>s')
map('n', '<leader>wv', '<c-w>v')
map('n', '<leader>w=', '<c-w>=')

--map('n', '<leader>e', ':Ex<cr>')
--map('n', '<leader>pv', ':wincmd v<bar> :Ex <bar> :vertical resize 25<cr>')
map('n', '<leader>+', ':vertical resize +5<cr>')
map('n', '<leader>-', ':vertical resize -5<cr>')

-- move lines up/down using Alt+k / Alt+j
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- toggle wrap mode
map('n', '<A-z>', ':set wrap!<CR>')

-- jump back to previous file
map('n', '<c-p>', ':e #<cr>')

-----------------------------------------------------------------------------
-- Telescope
-----------------------------------------------------------------------------
-- Find files using Telescope command-line sugar.
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- Using lua functions
--nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
--nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
--nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

-----------------------------------------------------------------------------
-- NerdTree
-----------------------------------------------------------------------------

map('n', '<leader>n', '<cmd>NERDTreeFocus<CR>')
map('n', '<C-n>', '<cmd>NERDTree<CR>')
map('n', '<C-t>', '<cmd>NERDTreeToggle<CR>')
map('n', '<C-f>', '<cmd>NERDTreeFind<CR>')

-----------------------------------------------------------------------------
