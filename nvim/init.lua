-- Aliases
-----------------------------------------------------------------------------

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

-- workaround to make simple settings until PR#13479 be released
-- see: https://github.com/neovim/neovim/pull/13479
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

-----------------------------------------------------------------------------
-- General settings
-----------------------------------------------------------------------------

opt('o', 'autoread', true)            -- reload files changed outside of Nvim
opt('o', 'visualbell', true)          -- use a visual bell instead of emit beep
opt('w', 'relativenumber', true)      -- show relative line distances
opt('w', 'number', true)              -- show current line number
opt('o', 'scrolloff', 8)              -- number of lines offset when jumping
local indent = 4                      -- indent size
opt('b', 'tabstop', indent)           -- number of spaces tabs count for
opt('b', 'softtabstop', indent)       -- number of spaces tabs count for while editing
opt('b', 'shiftwidth', indent)        -- size of an indent
opt('b', 'expandtab', true)           -- use space instead of tabs
opt('b', 'smartindent', true)         -- insert indents automatically
opt('o', 'showmatch', true)           -- highlight matching parens, braces, brackets, etc
opt('o', 'ignorecase', true)          -- ignore case
opt('o', 'smartcase', true)           -- don't ignore case with capitals
opt('o', 'hidden', true)              -- enable modified buffers in background
opt('o', 'wildmode', 'list:longest')  -- command-line completion mode
opt('o', 'statusline', '%F')          -- display full path in status line
opt('o', 'clipboard', 'unnamedplus')  -- use system clipboard
opt('w', 'wrap', false)               -- no wrap
opt('w', 'linebreak', true)           -- when wrap, not break words
opt('w', 'colorcolumn', '80')         -- color column position
opt('o', 'completeopt', 'menuone,noselect')
-- undo tree file
opt('o', 'undodir', '/home/iago/.vim/undodir')
opt('o', 'undofile', true)
--

-----------------------------------------------------------------------------
-- AutoCommands
-----------------------------------------------------------------------------

cmd("autocmd BufWritePre * if &ft!='markdown' | let position = winsaveview() | :%s/\\s\\+$//e | call winrestview(position) | unlet! position") -- rstrip white spaces when save except on markdown files
cmd("autocmd BufNewFile,BufReadPre *.md setlocal textwidth=71") -- auto break line at 71 chars in .md files
cmd("autocmd BufNewFile,BufReadPre *.md setlocal colorcolumn=72")

-- Highlight trailing white spaces
-- see: https://vim.fandom.com/wiki/Highlight_unwanted_spaces
vim.cmd("autocmd ColorScheme * highlight ExtraWhitespace ctermbg=218 guibg=218")
-- Use next line to highlight in insert mode if not typing at the end of a line
vim.cmd("autocmd BufNewFile,BufReadPre * match ExtraWhitespace /\\s\\+\\%#\\@<!$/")
-- Use following lines to highlight only in normal mode
--vim.cmd("autocmd InsertEnter * match")
--vim.cmd("autocmd InsertLeave * match ExtraWhitespace /\\s\\+$/")

-----------------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------------

vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

paq 'neovim/nvim-lspconfig'
paq 'nvim-treesitter/nvim-treesitter'
paq {'hrsh7th/nvim-compe', branch='master'}
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'
paq {'dracula/vim', as='dracula'}
paq 'vim-airline/vim-airline'
paq 'vim-airline/vim-airline-themes'
paq 'mhinz/vim-signify'
paq 'preservim/nerdtree'
paq 'Xuyuanp/nerdtree-git-plugin'
paq 'ryanoasis/vim-devicons'
paq 'tiagofumo/vim-nerdtree-syntax-highlight'
paq 'jiangmiao/auto-pairs'

-----------------------------------------------------------------------------
-- Colors
-----------------------------------------------------------------------------

g.dracula_colorterm=0
cmd 'colorscheme dracula'

-----------------------------------------------------------------------------
-- Mappings
-----------------------------------------------------------------------------

-- Helper function to create mappings
function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-----------------------------------------------------------------------------
-- General setup
-----------------------------------------------------------------------------

-- plugins configs
require('plugins/treesitter')
require('plugins/compe')
-- mappgins configs
require('mappings')

-----------------------------------------------------------------------------
