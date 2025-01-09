pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

local auto_install = require("lib.util").get_user_config("auto_install", true)
local installed_parsers = {}
if auto_install then
  installed_parsers = require("plugins.list").ts_parsers
end

require("nvim-treesitter.configs").setup {
  ensure_installed = installed_parsers,

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
