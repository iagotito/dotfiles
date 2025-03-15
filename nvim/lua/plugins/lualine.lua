require("lualine").setup({
	options = {
		theme = "dracula",
	},
	sections = {
		lualine_b = { "filename" },
		lualine_c = { "" },
		lualine_x = { "" },
		lualine_y = { "branch" },
	},
})
