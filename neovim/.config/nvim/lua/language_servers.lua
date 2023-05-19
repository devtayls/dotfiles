local lsp_config = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local attach = function(client, buffer_number) 

  local options = {
    buffer = buffer_number
  }

  vim.keymap.set('n', '<CR>', vim.lsp.buf.definition, options)
  -- show hover window of definition
  vim.keymap.set('n', '<LEADER>lh', vim.lsp.buf.hover, options)
  vim.keymap.set('n', '<LEADER>lO', vim.lsp.buf.document_symbol, options)
  -- show Telescop window listing lsp object
  vim.keymap.set('n', '<LEADER>lo', ':Telescope lsp_document_symbols<CR>', options)


  if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = formatting_augrop, buffer = buffer_number })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = formatting_augrop,
        buffer = buffer_number,
        callback = function() vim.lsp.buf.format() end
      })
    end
end

lsp_config.elixirls.setup({
  cmd = {'elixir-ls'},
  on_attach = attach, 
  capabilities = capabilities,
  settings = { 
    elixirLS = { 
      dialyzerEnabled = true 
    }
  }
})
