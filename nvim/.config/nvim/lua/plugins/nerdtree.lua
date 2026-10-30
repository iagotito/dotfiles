return {
	{
		"preservim/nerdtree",
		dependencies = {
			"johnstef99/vim-nerdtree-syntax-highlight",
			"Xuyuanp/nerdtree-git-plugin",
			-- NERDTree sources devicons' nerdtree_plugin/ on load, so it must be a dependency
			"ryanoasis/vim-devicons",
		},
		config = function()
			-- Exit Vim if NERDTree is the only window remaining in the only tab.
			vim.cmd(
				[[autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
			)

			-- Close the tab if NERDTree is the only window remaining in it.
			vim.cmd(
				[[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
			)

			-- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
			vim.cmd(
				[[autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif]]
			)

			-- Git status: hide the [ ] around the indicator and use Nerd Font symbols
			vim.g.NERDTreeGitStatusConcealBrackets = 1
			vim.g.NERDTreeGitStatusUseNerdFonts = 1
			-- Don't reserve an empty git column on clean files (git plugin and devicons both did)
			vim.g.NERDTreeGitStatusAlignIfConceal = 0
			vim.g.WebDevIconsNerdTreeGitPluginForceVAlign = 0
			vim.g.WebDevIconsNerdTreeBeforeGlyphPadding = ""

			-- Show hidden files by default
			vim.g.NERDTreeShowHidden = 1

			-- Ignore patterns
			vim.g.NERDTreeIgnore = { ".venv$[[dir]]", ".git$[[dir]]", "__pycache__$[[dir]]", ".pytest_cache$[[dir]]" }

			-- Keymaps
			require("keymaps.util")

			map("n", "<leader>n", "<cmd>NERDTreeFocus<CR>")
			map("n", "<C-n>", "<cmd>NERDTree<CR>")
			--map('n', '<C-t>', '<cmd>NERDTreeToggle<CR>')
			map("n", "<C-f>", "<cmd>NERDTreeFind<CR>")
		end,
	},
}
