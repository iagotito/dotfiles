require 'paq' {
    'savq/paq-nvim';                  -- Let Paq manage itself

    'neovim/nvim-lspconfig';
    'nvim-lua/completion-nvim';
    'steelsojka/completion-buffers';
    'norcalli/snippets.nvim';
    --'ray-x/lsp_signature.nvim';

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

    'jiangmiao/auto-pairs';
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
require'plugins.snippets'
require'plugins.completion'
require'plugins.undotree'

-----------------------------------------------------------------------------
