return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
    build = ":TSUpdate",
		config = function()
      vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					local lang = vim.treesitter.language.get_lang(ft) or ft
					if vim.treesitter.language.add(lang) then
						vim.treesitter.start(args.buf, lang)
					end
				end,
			})
			-- Change the keys color to light blue (the color of '@constructor' highlight group) in json and jsonc files
			vim.api.nvim_set_hl(0, "@property.jsonc", { link = "@constructor" })
			vim.api.nvim_set_hl(0, "@property.json", { link = "@constructor" })
		end,
	},
}
