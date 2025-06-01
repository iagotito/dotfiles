return {
	{
		"dracula/vim",
		as = "dracula",
		config = function()
			vim.g.dracula_colorterm = 0
			vim.cmd("colorscheme dracula")
		end,
	},
}
