require("keymaps.util")

vim.g.mapleader = " " -- set `space` as leader key

-- clycle through buffers
map("n", "<c-tab>", ":bn<cr>")
map("n", "<leader><tab>", ":bn<cr>")
map("n", "<s-tab>", ":bp<cr>")

-- manage tabs
map("n", "<c-t>", ":tabnew<cr>")
map("n", "t", ":+tabnext<cr>")
map("n", "T", ":-tabnext<cr>")

-- jump back to previous file
map("n", "<c-p>", ":e #<cr>")

map("n", "<leader>l", "<cmd>noh<cr>") -- clear highlights

-- windows navigation with leader instead of Ctrl
map("n", "<leader>wh", "<c-w>s")
map("n", "<leader>wv", "<c-w>v")
map("n", "<leader>w=", "<c-w>=")

--map('n', '<leader>e', ':Ex<cr>')
--map('n', '<leader>pv', ':wincmd v<bar> :Ex <bar> :vertical resize 25<cr>')
map("n", "<leader>+", ":vertical resize +5<cr>")
map("n", "<leader>-", ":vertical resize -5<cr>")

-- move lines up/down using Alt+k / Alt+j
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- keep visual selecion when changing indentation
map("v", ">", ">gv")
map("v", "<", "<gv")

-- when paste text into visual selection, throw replaced text
-- into void register
map("x", "p", '"_dP')

-- toggle wrap mode
map("n", "<A-z>", ":set wrap!<CR>")

-- Y to yank to the end of the line
map("n", "Y", "y$")

-- undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "(", "(<c-g>u")
map("i", ")", ")<c-g>u")
map("i", "[", "[<c-g>u")
map("i", "]", "]<c-g>u")
map("i", "{", "{<c-g>u")
map("i", "}", "}<c-g>u")
map("i", '"', '"<c-g>u')
map("i", "'", "'<c-g>u")

-- Quickly replace current word
map("n", "<leader><c-r>", "*N:%s// /gI|noh|normal!``<c-left><left><del>")
-- Quickly replace current word and ask conirmation
map("n", "<leader>R", "*N:%s// /gcI|noh|normal!``<c-left><left><del>")

-- Replace inside pairs with register content
map("n", "ri'", "vi'p")
map("n", 'ri"', 'vi"p')
map("n", "ri(", "vi(p")
map("n", "ri)", "vi)p")
map("n", "ri[", "vi[p")
map("n", "ri]", "vi]p")
map("n", "ri{", "vi{p")
map("n", "ri}", "vi}p")
map("n", "riw", "viwp")

-- Find without change cursor position
map("n", "*", "*N")
map("n", "#", "#N")

-- Commands
-- prevent errors with shift when saving or quiting
vim.cmd(":command W w")
vim.cmd(":command Wq wq")
vim.cmd(":command WQ wq")
vim.cmd(":command Wa wa")
vim.cmd(":command WA wa")
vim.cmd(":command Q q")
vim.cmd(":command QA qa")
