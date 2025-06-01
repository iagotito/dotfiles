return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
				--ensure_installed = {
				--"lua", "python", "vimdoc", "vim", "html", "javascript", "typescript",
				--"json", "yaml", "terraform", "go", "sql", "markdown_inline", "luadoc",
				--"c", "query",
				--},
				--sync_install = false,  -- Ensures parsers are installed only once.
				--auto_install = true,   -- Automatically install missing parsers.
			})

			require("nvim-treesitter.install").prefer_git = true

			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.csharp = {
				install_info = {
					url = "https://github.com/tree-sitter/tree-sitter-c-sharp", -- local path or git repo
					files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
					-- optional entries:
					branch = "master", -- default branch in case of git repo if different from master
					generate_requires_npm = false, -- if stand-alone parser without npm dependencies
					requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				},
				filetype = "cs", -- if filetype does not match the parser name
			}

			vim.filetype.add({
				extension = {
					keymap = "c",
				},
			})
		end,
	},
}
