return {
	{
		"hoob3rt/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					--theme = require("plugins.lualinetheme").theme(),
					--theme = "catppuccin",
					theme = "dracula",
				},
				sections = {
					lualine_b = { "filename" },
					lualine_c = { "" },
					lualine_x = { "" },
					lualine_y = { "branch" },
				},
			})
		end,
	},
}
