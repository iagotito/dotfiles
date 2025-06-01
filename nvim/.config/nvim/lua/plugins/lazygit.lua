return {
	{
		"kdheepak/lazygit.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", {
				desc = "Open LazyGit",
				silent = true,
				noremap = true,
			})
		end,
	},
}
