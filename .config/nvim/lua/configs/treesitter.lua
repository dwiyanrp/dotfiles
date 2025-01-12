pcall(function()
  dofile(vim.g.base46_cache .. 'syntax')
  dofile(vim.g.base46_cache .. 'treesitter')
end)

local treesitter = require 'nvim-treesitter.configs'

local auto_install = require('lib.util').get_user_config('auto_install', true)
local installed_parsers = {}
if auto_install then
  installed_parsers = require('plugins.list').ts_parsers
end

treesitter.setup {
  modules = {},
  sync_install = false,
  ensure_installed = installed_parsers,
  ignore_install = {},
  auto_install = true,
}
