-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  html = {},
  cssls = {},
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        completeUnimported = true,
        usePlaceholders = true,
      },
    },
  },
}
local nvlsp = require "nvchad.configs.lspconfig"

for name, opts in pairs(servers) do
  opts.on_attach = nvlsp.on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities
  lspconfig[name].setup(opts)
end
