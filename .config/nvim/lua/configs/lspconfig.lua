local lspconfig = require 'lspconfig'
local icons = require('lib.icons').diagnostics
local blink_capabilities = require('blink.cmp').get_lsp_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

-- Set up diagnostic signs
for type, icon in pairs { Error = icons.Error, Warn = icons.Warning, Hint = icons.Hint, Info = icons.Information } do
  vim.fn.sign_define('DiagnosticSign' .. type, { text = icon, texthl = 'DiagnosticSign' .. type, numhl = '' })
end

-- Default LSP setup
local function setup_lsp(server)
  lspconfig[server].setup { capabilities = blink_capabilities }
end

-- Custom setup for Lua
local function setup_lua_ls()
  lspconfig.lua_ls.setup {
    capabilities = blink_capabilities,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = { library = { vim.env.VIMRUNTIME } },
        format = {
          enable = true,
          defaultConfig = {
            align_continuous_assign_statement = false,
            align_continuous_rect_table_field = false,
            align_array_table = false,
          },
        },
      },
    },
  }
end

-- Mason LSP setup
require('mason-lspconfig').setup {
  ensure_installed = require('lib.util').get_user_config('auto_install', true) and require('plugins.list').lsp_servers or {},
  handlers = {
    setup_lsp, -- Default handler
    lua_ls = setup_lua_ls, -- Custom Lua handler
  },
}
