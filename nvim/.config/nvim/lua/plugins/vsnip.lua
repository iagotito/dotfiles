return {
	{
		"hrsh7th/vim-vsnip",
		dependencies = {
			"hrsh7th/cmp-vsnip",
		},
		config = function()
			vim.g.vsnip_snippet_dir = "$HOME/.config/nvim/snippets/"
		end,
	},
}
