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
opt('o', 'scrolloff', 6)              -- number of lines offset when jumping
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
    opt('w', 'colorcolumn', '80')         -- color column position
--opt('o', 'nobackup', true)            -- don't create `filename~` backups
--opt('o', 'noswapfile', true)          -- don't create temp files
-- undo tree file
opt('o', 'undodir', '/home/iago/.vim/undodir')
opt('o', 'undofile', true)
--

-----------------------------------------------------------------------------
-- Plugins
-----------------------------------------------------------------------------

vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

paq {'nvim-treesitter/nvim-treesitter'}
paq 'neovim/nvim-lspconfig'
paq {'shougo/deoplete-lsp'}
paq {'shougo/deoplete.nvim', hook = fn['remote#host#UpdateRemotePlugins']}
--paq 'nvim-lua/completion-nvim'
paq{'dracula/vim', as='dracula'}   -- Use braces when passing options
                                   -- Use `as` to alias a package name (here `vim`)

-----------------------------------------------------------------------------
-- Colors
-----------------------------------------------------------------------------

g.dracula_colorterm=0
cmd 'colorscheme dracula'

-----------------------------------------------------------------------------
-- Plugins configurations
-----------------------------------------------------------------------------

g['deoplete#enable_at_startup'] = 1  -- enable deoplete at startup
-- Tree-sitter --
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}
-----------------
------ LSP ------
local lsp = require 'lspconfig'
-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
lsp.pyright.setup{root_dir = lsp.util.root_pattern('.git', fn.getcwd())}
-----------------
--- Completion --
--lsp.pyright.setup{on_attach=require'completion'.on_attach}
-----------------
-----------------------------------------------------------------------------
-- Mappings
-----------------------------------------------------------------------------

-- Helper function to create mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader=' ' -- set `space` as leader key

map('n', '<leader>bn', ':bn<cr>')  -- buffer next
map('n', '<leader>l', '<cmd>noh<CR>')  -- clear highlights

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
