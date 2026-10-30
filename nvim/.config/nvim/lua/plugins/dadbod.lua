return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
			"DBUIRenameBuffer",
			"DBUILastQueryInfo",
		},
		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod_ui"
			vim.g.db_ui_use_nvim_notify = 0
			vim.g.db_ui_disable_info_notifications = 1 -- no "Connected to db..." noise, errors still show
			vim.g.db_ui_force_echo_notifications = 1 -- errors/warnings via :echo, not the floating window (white bg)
			vim.g.db_ui_execute_on_save = 0 -- run queries with <leader>S, not on :w
			vim.g.db_ui_auto_execute_table_helpers = 1
		end,
		config = function()
			-- completion for sql buffers (nvim-cmp is configured in cmp.lua)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer", keyword_length = 5 },
						},
					})
				end,
			})
		end,
	},
}
