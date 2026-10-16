return {
	{
		"3rd/diagram.nvim",
		dependencies = {
			{
				"3rd/image.nvim",
				opts = {
					backend = "kitty",
					processor = "magick_cli",
				},
			},
		},
		ft = { "markdown" },
		opts = function()
			return {
				integrations = { require("diagram.integrations.markdown") },
				renderer_options = {
					mermaid = { theme = "dark", scale = 3 },
				},
			}
		end,
		keys = {
			{
				"<leader>md",
				function()
					require("diagram").show_diagram_hover()
				end,
				ft = { "markdown" },
				desc = "Show diagram in new tab",
			},
		},
	},
}
