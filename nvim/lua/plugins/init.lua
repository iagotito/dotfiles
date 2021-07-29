vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

paq 'neovim/nvim-lspconfig'
paq 'kabouzeid/nvim-lspinstall'
paq 'ray-x/lsp_signature.nvim'
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
paq 'alvan/vim-closetag'
paq 'christoomey/vim-tmux-navigator'
paq 'preservim/nerdcommenter'
paq 'norcalli/snippets.nvim'
paq 'tpope/vim-fugitive'

-----------------------------------------------------------------------------
-- Colors
-----------------------------------------------------------------------------

vim.g.dracula_colorterm=0
vim.cmd 'colorscheme dracula'

-----------------------------------------------------------------------------
-- Plugins configs
-----------------------------------------------------------------------------

require('plugins/treesitter')
--require('plugins/compe')
require('plugins/closetag')
require('plugins/snippets')
require('plugins/telescope')

-----------------------------------------------------------------------------
