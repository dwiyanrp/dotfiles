vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local icons = require "lib.icons"
local plugins = require("plugins.list").plugins

lazy.setup {
  defaults = { lazy = true },
  spec = plugins,
  install = { colorscheme = { "nvchad" } },

  ui = {
    size = { width = 0.9, height = 0.8 },
    wrap = true,
    border = "rounded",
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
    browser = nil,
    throttle = 20,
    custom_keys = {
      ["<localleader>l"] = function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,

      ["<localleader>t"] = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },

  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
