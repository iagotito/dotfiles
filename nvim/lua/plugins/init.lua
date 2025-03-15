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
require("lazy").setup({
	spec = {
		-- import your plugins
		--{ import = 'plugins' },

		-----------------------------------------------------------------------------
		----- Colorscheme
		-----------------------------------------------------------------------------

		{
			"dracula/vim",
			as = "dracula",
			config = function()
				vim.g.dracula_colorterm = 0
				vim.cmd("colorscheme dracula")
			end,
		},

		-----------------------------------------------------------------------------
		----- Plugins
		-----------------------------------------------------------------------------

		-- Tools
		{
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("plugins.treesitter")
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("plugins.telescope")
			end,
		},
		{
			"preservim/nerdtree",
			config = function()
				require("plugins.nerdtree")
			end,
		},
		{
			"mbbill/undotree",
			config = function()
				require("plugins.undotree")
			end,
		},
		{
			"folke/trouble.nvim",
			config = function()
				require("plugins.trouble")
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			config = function()
				require("plugins.cmp")
			end,
		},
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{
			"hrsh7th/vim-vsnip",
			config = function()
				require("plugins.vsnip")
			end,
		},
		{ "hrsh7th/cmp-vsnip" },
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{
			"tpope/vim-fugitive",
			--config = function() require('plugins.fugitive').setup() end
		},
		{ "tpope/vim-abolish" },

		-- Quality of file
		{ "christoomey/vim-tmux-navigator" },
		{ "Xuyuanp/nerdtree-git-plugin" },
		{ "johnstef99/vim-nerdtree-syntax-highlight" },
		{ "preservim/nerdcommenter" },
		{ "mhinz/vim-signify" },
		{ "ryanoasis/vim-devicons" },
		{ "godlygeek/tabular" },
		{
			"windwp/nvim-autopairs",
			config = function()
				require("plugins.autopairs")
			end,
		},
		{
			"alvan/vim-closetag",
			config = function()
				require("plugins.closetag")
			end,
		},
		{
			"m4xshen/smartcolumn.nvim",
			opts = {},
		},
		{
			"hoob3rt/lualine.nvim",
			config = function()
				require("plugins.lualine")
			end,
		},
		{
			"stevearc/conform.nvim",
			opts = {},
			config = function()
				require("plugins.conform")
			end,
		},
	},
	-- automatically check for plugin updates
	checker = {
		enabled = true,
		notify = false,
	},
})

require("plugins.lsp")
