-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
	mapping = {
		--['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		--['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		--['<C-Space>'] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "vsnip" },
		{ name = "buffer", keyword_length = 5 },
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	experimental = {
		ghost_text = true,
	},
})

-- Dadbod config
--cmp.setup.filetype({ "sql" }, {
--sources = {
--{ name = "vim-dadbod-completion" },
--{ name = "buffer" },
--},
--})

require("lspconfig").volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	init_options = {
		typescript = {
			tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
		},
	},
})
