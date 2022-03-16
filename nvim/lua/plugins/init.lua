require 'paq' {
    'savq/paq-nvim';                  -- Let Paq manage itself

    'neovim/nvim-lspconfig';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/nvim-cmp';
    'hrsh7th/cmp-vsnip';
    'hrsh7th/vim-vsnip';
    'hrsh7th/vim-vsnip-integ';

    'nvim-treesitter/nvim-treesitter';

    {'dracula/vim', as='dracula'};
    'hoob3rt/lualine.nvim';
    'mhinz/vim-signify';
    'ryanoasis/vim-devicons';

    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';
    'preservim/nerdtree';
    'Xuyuanp/nerdtree-git-plugin';
    'tiagofumo/vim-nerdtree-syntax-highlight';

    'windwp/nvim-autopairs';
    'iagotito/smart-semicolon.nvim',
    'alvan/vim-closetag';
    'christoomey/vim-tmux-navigator';
    'preservim/nerdcommenter';
    'tpope/vim-fugitive';
    'mbbill/undotree';
}


-----------------------------------------------------------------------------
-- Colors
-----------------------------------------------------------------------------

vim.g.dracula_colorterm=0
vim.cmd 'colorscheme dracula'

-----------------------------------------------------------------------------
-- Plugins configs
-----------------------------------------------------------------------------

require'plugins.treesitter'
require'plugins.telescope'
require'plugins.fugitive'
require'plugins.nerdtree'
require'plugins.lualine'
require'plugins.closetag'
require'plugins.cmp'
require'plugins.vsnip'
require'plugins.undotree'
require'plugins.autopairs'
require'plugins.smart_semicolon'

-----------------------------------------------------------------------------
