" General settings
" Based on: https://gist.github.com/mendeza/e0c4fbb5592ad52f5eca77ed5873a46b#file-vimrc-L86
" ---------------------------------------------------------------------------

" number of lines at the beginning and end of files checked for file-specific vars
set modelines=0

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" use Unicode
set encoding=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,euc-jp,cp932

" errors flash screen rather than emit beep
set visualbell

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" undo tree file
set undodir=~/.vim/undodir
set undofile

" line numbers and distances
set relativenumber
set number

" number of lines offset when jumping
set scrolloff=6

" Tab key enters 4 spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab

" indentation
set smartindent

" statusline indicates insert or normal mode
set showmode showcmd

" make scrolling and painting fast
set lazyredraw

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set nohlsearch incsearch ignorecase smartcase

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir

" open new buffers without saving current modifications (buffer remains open)
set hidden

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full

" StatusLine always visible, display full path
" set laststatus=2 statusline=%F

" Use system clipboard
set clipboard=unnamedplus

" Show character column
highlight ColorColumn ctermbg=Gray
set colorcolumn=80

" ---------------------------------------------------------------------------
" Plugins (with vim-plug)
" ---------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" ---------------------------------------------------------------------------
" Colors
" ---------------------------------------------------------------------------

let g:dracula_colorterm = 0
syntax enable
colorscheme dracula

" ---------------------------------------------------------------------------
" Remaps
" ---------------------------------------------------------------------------

let mapleader = " "
nnoremap <leader>bn :bn<cr> ;buffer next

" ---------------------------------------------------------------------------
"  Auto commands
" ---------------------------------------------------------------------------

augroup MY_AUTOGROUP
    autocmd!
    " Trim white spaces when save buffer
    autocmd BufWritePre * %s/\s\+$//e
augroup END

" ---------------------------------------------------------------------------
