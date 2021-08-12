require'keymaps.util'

map('n', '<leader>gs', ':G<cr>')  -- git status
map('n', '<leader>gh', ':diffget //2<cr>')  -- select left
map('n', '<leader>gl', ':diffget //3<cr>')  -- select right
map('n', '<leader>gc', ':Git commit<cr>')  -- git commit
map('n', '<leader>gp', ':Git push -u origin HEAD<cr>')  -- git push
