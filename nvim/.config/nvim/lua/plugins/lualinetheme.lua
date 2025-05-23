-- based on: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/dracula.lua
-- and: https://www.reddit.com/r/neovim/comments/s4ud1d/make_lualine_background_transparent/
local M = {}
M.theme = function()
	local colors = {
		gray = "#44475a",
		lightgray = "#5f6a8e",
		orange = "#ffb86c",
		purple = "#bd93f9",
		red = "#ff5555",
		yellow = "#f1fa8c",
		green = "#50fa7b",
		white = "#f8f8f2",
		black = "#282a36",
		trans = nil,
	}

	return {
		normal = {
			a = { bg = colors.purple, fg = colors.black, gui = "bold" },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.trans, fg = colors.white },
		},
		insert = {
			a = { bg = colors.green, fg = colors.black, gui = "bold" },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.trans, fg = colors.white },
		},
		visual = {
			a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.trans, fg = colors.white },
		},
		replace = {
			a = { bg = colors.red, fg = colors.black, gui = "bold" },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.trans, fg = colors.white },
		},
		command = {
			a = { bg = colors.orange, fg = colors.black, gui = "bold" },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.trans, fg = colors.white },
		},
		inactive = {
			a = { bg = colors.gray, fg = colors.white, gui = "bold" },
			b = { bg = colors.lightgray, fg = colors.white },
			c = { bg = colors.trans, fg = colors.white },
		},
	}
end
return M
