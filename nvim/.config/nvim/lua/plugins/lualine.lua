require("lualine").setup({
	options = {
		--theme = require("plugins.lualinetheme").theme(),
    theme = "catppuccin",
	},
	sections = {
		lualine_b = { "filename" },
		lualine_c = { "" },
		lualine_x = { "" },
		lualine_y = { "branch" },
	},
})
