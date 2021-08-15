-- if set, let undotree window get focus after being opened, otherwise
-- focus will stay in current window.
vim.api.nvim_exec(
[[
if !exists('g:undotree_SetFocusWhenToggle')
    let g:undotree_SetFocusWhenToggle = 1
endif
]],
true
)

-- Keymaps
require 'keymaps.util'

map('n', '<F5>', ':UndotreeToggle<CR>')
