require 'options'
require 'plugins.lazy'
require 'autocmds'

vim.schedule(function()
  require 'keymaps'
end)
