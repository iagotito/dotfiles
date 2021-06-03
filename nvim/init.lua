-----------------------------------------------------------------------------
-- Aliases
-----------------------------------------------------------------------------

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt

-----------------------------------------------------------------------------
-- General settings
-----------------------------------------------------------------------------

opt.autoread = true -- reload files changed outside of Nvim
opt.visualbell = true -- use a visual bell instead of emit beep
opt.relativenumber = true -- show relative line distances
opt.number = true -- show current line number
opt.scrolloff = 8 -- number of lines offset when jumping
opt.tabstop = 4 -- number of spaces tabs count for
opt.softtabstop = 4 -- number of spaces tabs count for while editing
opt.shiftwidth = 4 -- size of an indent
opt.expandtab = true -- use space instead of tabs
opt.smartindent = true -- insert indents automatically
opt.showmatch = true -- highlight matching parens, braces, brackets, etc
opt.ignorecase = true -- ignore case
opt.smartcase = true -- don't ignore case with capitals
opt.hidden = true -- enable modified buffers in background
opt.wildmode = {'list', 'longest'} -- command-line completion mode
opt.statusline = '%F' -- display full path in status line
opt.clipboard = 'unnamedplus' -- use system clipboard
opt.wrap = false -- no wrap
opt.linebreak = true -- when wrap, not break words
opt.colorcolumn = '80' -- color column position
opt.completeopt = {'menuone', 'noselect'}
-- undo tree file
opt.undodir = '/home/iago/.nvim/undodir'
opt.undofile = true

-----------------------------------------------------------------------------
-- AutoCommands
-----------------------------------------------------------------------------

cmd("autocmd BufWritePre * if &ft!='markdown' | let position = winsaveview() | :%s/\\s\\+$//e | call winrestview(position) | unlet! position") -- rstrip white spaces when save except on markdown files
cmd("autocmd BufNewFile,BufReadPre *.md setlocal textwidth=71 colorcolumn=72") -- auto break line at 71 chars in .md files
cmd("autocmd BufNewFile,BufReadPre *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2") -- auto break line at 71 chars in .md files

-- Highlight trailing white spaces
-- see: https://vim.fandom.com/wiki/Highlight_unwanted_spaces
cmd("autocmd ColorScheme * highlight ExtraWhitespace ctermbg=218 guibg=218")
-- Use next line to highlight in insert mode if not typing at the end of a line
cmd("autocmd BufNewFile,BufReadPre * match ExtraWhitespace /\\s\\+\\%#\\@<!$/")
-- Use following lines to highlight only in normal mode
--cmd("autocmd InsertEnter * match")
--cmd("autocmd InsertLeave * match ExtraWhitespace /\\s\\+$/")

-----------------------------------------------------------------------------
-- General setup
-----------------------------------------------------------------------------

require('plugins')
require('lsp')
require('keymaps')

-----------------------------------------------------------------------------
