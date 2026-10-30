return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		ft = { "markdown" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			-- Raw text only on the cursor line, rendered everywhere else
			anti_conceal = { enabled = true },
			-- Boxed tables, columns aligned to the widest cell
			pipe_table = { preset = "round", style = "full", cell = "padded" },
			code = { sign = false, width = "block", right_pad = 1 },
			heading = { sign = false },
		},
		keys = {
			{ "<leader>mr", "<cmd>RenderMarkdown buf_toggle<cr>", ft = "markdown", desc = "Toggle markdown render (buffer)" },
			{ "<leader>mR", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle markdown render (global)" },
			{ "<leader>me", "<cmd>RenderMarkdown expand<cr>", ft = "markdown", desc = "Markdown: expand conceal" },
			{ "<leader>mc", "<cmd>RenderMarkdown contract<cr>", ft = "markdown", desc = "Markdown: contract conceal" },
			{ "<leader>mp", "<cmd>RenderMarkdown preview<cr>", ft = "markdown", desc = "Markdown: side preview split" },
			{ "<leader>mg", "<cmd>vsplit | terminal glow -p %<cr>", ft = "markdown", desc = "Open file in glow" },
		},
	},
}
