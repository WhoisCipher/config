local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
})

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
  mapping = {
    ['<C-W>'] = cmp.mapping.select_prev_item(),
    ['<C-S>'] = cmp.mapping.select_next_item(),
    ['<C-Return>'] = cmp.mapping.confirm({ select = true }),
  },
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'ts_ls', 'rust_analyzer', 'clangd', 'kotlin_language_server' },
  handlers = {
    function(server_name)
      local opts = {
        on_attach = lsp_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      }
      
      require('lspconfig')[server_name].setup(opts)
    end,
  }
})
