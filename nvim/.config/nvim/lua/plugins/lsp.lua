-- Use an on_attach function to map keys after the language server attaches
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

return {
	-- Mason: Manages LSP server installations
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- Mason-LSPConfig: Bridges Mason and nvim-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Configure inline diagnostics
			vim.diagnostic.config({
				virtual_text = {
					prefix = "■",
					source = "always",
					spacing = 4,
				},
				signs = {
					active = true,
					text = {
						[vim.diagnostic.severity.ERROR] = "❌",
						[vim.diagnostic.severity.WARN] = "⚠",
						[vim.diagnostic.severity.INFO] = "ℹ",
						[vim.diagnostic.severity.HINT] = "💡",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Language servers
			local servers = { "pyright", "lua_ls", "ts_ls", "gopls", "rust_analyzer" }

			-- Ensure servers are installed via mason-lspconfig
			--require("mason-lspconfig").setup({
			--ensure_installed = servers,
			--automatic_installation = true,
			--})

			-- Setup LSP servers with nvim-lspconfig
			local nvim_lsp = require("lspconfig")
			for _, lsp in ipairs(servers) do
				local capabilities =
					require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
				nvim_lsp[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					flags = {
						debounce_text_changes = 150,
					},
				})
			end
		end,
	},
	-- CMP-Nvim-LSP: LSP source for nvim-cmp
	--{
	--"hrsh7th/cmp-nvim-lsp",
	--config = function()
	--require("lspconfig").volar.setup({
	--filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	--init_options = {
	--typescript = {
	--tsdk = vim.fn.stdpath("data")
	--.. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
	--},
	--},
	--})
	--end,
	--},
}
