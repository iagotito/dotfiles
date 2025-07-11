-----------------------------------------------------------------------------
-- Aliases
-----------------------------------------------------------------------------

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt

----------------------------------------------------------------------------
-- General settings
-----------------------------------------------------------------------------

opt.autoread = true -- reload files changed outside of Nvim
opt.visualbell = true -- use a visual bell instead of emit beep
opt.relativenumber = true -- show relative line distances
opt.number = true -- show current line number
opt.scrolloff = 8 -- number of lines offset when jumping
opt.tabstop = 2 -- number of spaces tabs count for
opt.softtabstop = 2 -- number of spaces tabs count for while editing
opt.shiftwidth = 2 -- size of an indent
opt.expandtab = true -- use space instead of tabs
opt.smartindent = true -- insert indents automatically
opt.showmatch = true -- highlight matching parens, braces, brackets, etc
opt.ignorecase = true -- ignore case
opt.smartcase = true -- don't ignore case with capitals
opt.hidden = true -- enable modified buffers in background
opt.wildmode = { "list", "longest" } -- command-line completion mode
opt.statusline = "%F" -- display full path in status line
opt.clipboard = "unnamedplus" -- use system clipboard
opt.wrap = false -- no wrap
opt.linebreak = true -- when wrap, not break words
--opt.colorcolumn = "80" -- color column position
opt.completeopt = { "menu", "menuone", "noselect" }
opt.mouse = "a"
opt.filetype = "on"
--opt.plugin = "on"
-- undo tree file
home = os.getenv("HOME")
opt.undodir = home .. "/.config/nvim/undodir"
opt.undofile = true

-----------------------------------------------------------------------------
-- AutoCommands
-----------------------------------------------------------------------------

cmd(
	"autocmd BufWritePre * if &ft!='markdown' | let position = winsaveview() | :%s/\\s\\+$//e | call winrestview(position) | unlet! position"
) -- rstrip white spaces when save except on markdown files
cmd("autocmd BufNewFile,BufReadPre *.md setlocal textwidth=71") -- colorcolumn=72") -- auto break line at 71 chars in .md files
cmd("autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4") -- set tab to 4 spaces in selected filetypes
cmd("autocmd FileType go setlocal noexpandtab") -- use tab for identation in go files

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

require("keymaps")
--require("plugins")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({ import = "plugins" })

-----------------------------------------------------------------------------
