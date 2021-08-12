-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_exec(
[[
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]],
true
)

-- Use <Tab> as trigger key
vim.api.nvim_exec(
[[
    imap <tab> <Plug>(completion_smart_tab)
    imap <s-tab> <Plug>(completion_smart_s_tab)
]],
true
)

-- Set completeopt to have a better completion experience
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

-- Avoid showing message extra message when using completion
table.insert(vim.opt.shortmess, 'c')

-- possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
vim.g.completion_enable_snippet = 'snippets.nvim'

-- trigger on delete
vim.g.completion_trigger_on_delete = 1

-- add buffer completion from completion-buffers
vim.g.completion_chain_complete_list = {
  default = {
    --{ complete_items = { 'lsp' } },
    { complete_items = { 'lsp', 'snippet', 'buffers' } },
    --{ mode = { '<c-p>' } },
    --{ mode = { '<c-n>' } }
  },
}
