require'keymaps.util'

map('n', '<leader>gs', ':G<cr>')  -- git status
map('n', '<leader>gd', ':Gvdiffsplit!<cr>') -- resolve merge conflicts
map('n', 'gh', ':diffget //2<cr>')  -- select left
map('n', 'gl', ':diffget //3<cr>')  -- select right
map('n', '<leader>gc', ':Git commit<cr>')  -- git commit
map('n', '<leader>gp', ':Git push -u origin HEAD<cr>')  -- git push
