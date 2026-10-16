return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		init = function()
			-- ufo needs a large foldlevel so folds don't auto-close
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		config = function()
			local ufo = require("ufo")

			ufo.setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})

			-- `zR`/`zM` replacements that keep ufo's folds working
			vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
			-- K is already mapped to LSP hover in lsp.lua, so peek lives on zK
			vim.keymap.set("n", "zK", function()
				if not ufo.peekFoldedLinesUnderCursor() then
					vim.lsp.buf.hover()
				end
			end, { desc = "Peek folded lines" })
		end,
	},
}
