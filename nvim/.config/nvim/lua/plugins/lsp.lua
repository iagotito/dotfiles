-- Use an on_attach function to map keys after the language server attaches
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  local opts = { buffer = bufnr, silent = true }

  -- Mappings
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

return {
  -- Mason: Manages LSP server installations
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPConfig: Bridges Mason and the built-in LSP (Neovim 0.11+)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = "■",
          source = "always",
          spacing = 4,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "❌",
            [vim.diagnostic.severity.WARN]  = "⚠",
            [vim.diagnostic.severity.INFO]  = "ℹ",
            [vim.diagnostic.severity.HINT]  = "💡",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Language servers
      local servers = { "pyright", "lua_ls", "ts_ls", "gopls", "rust_analyzer" }

      -- Ensure servers are installed
      --require("mason-lspconfig").setup({
        --ensure_installed = servers,
      --})

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Define LSP configs using the NEW Neovim API
      for _, server in ipairs(servers) do
        vim.lsp.config[server] = {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }
      end

      -- Lua-specific settings (kept inline, no extra sections)
      vim.lsp.config.lua_ls = vim.tbl_deep_extend(
        "force",
        vim.lsp.config.lua_ls or {},
        {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        }
      )

      -- Enable all servers
      vim.lsp.enable(servers)
    end,
  },
}
