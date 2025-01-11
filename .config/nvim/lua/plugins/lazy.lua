local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local plugins = require('plugins.list').plugins
local icons = require 'lib.icons'

require('lazy').setup {
  spec = plugins,
  ui = {
    border = 'rounded',
    browser = nil,
    icons = {
      cmd = icons.ui.Terminal,
      config = icons.ui.Gear,
      event = icons.ui.Electric,
      ft = icons.documents.File,
      init = icons.ui.Rocket,
      import = icons.documents.Import,
      keys = icons.ui.Keyboard,
      lazy = icons.ui.Sleep,
      loaded = icons.ui.CircleSmall,
      not_loaded = icons.ui.CircleSmallEmpty,
      plugin = icons.ui.Package,
      runtime = icons.ui.Neovim,
      source = icons.ui.Code,
      start = icons.ui.Play,
      task = icons.ui.Check,
      list = {
        icons.ui.CircleSmall,
        icons.ui.Arrow,
        icons.ui.Star,
        icons.ui.Minus,
      },
    },
    size = { width = 0.9, height = 0.8 },
    throttle = 20,
    wrap = true,
  },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
}
