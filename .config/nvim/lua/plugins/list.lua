local function load_config(package)
  return function()
    require(package)
  end
end

-- NOTE: Here is where you install your plugins.
local plugins = {
  { -- NvChad
    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    {
      'nvchad/ui',
      config = function()
        require 'nvchad'
      end,
    },
    {
      'nvchad/base46',
      lazy = true,
      build = function()
        require('base46').load_all_highlights()
      end,
    },
    'nvchad/volt',
  },

  { -- NvimTree
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = load_config 'configs.nvimtree',
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    config = load_config 'configs.treesitter',
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      'nvim-treesitter/nvim-treesitter',
      'debugloop/telescope-undo.nvim',
    },
    cmd = 'Telescope',
    config = load_config 'configs.telescope',
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = load_config 'configs.gitsigns',
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = require 'opts.whichkey',
  },

  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = load_config 'configs.lspconfig',
  },
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
    config = load_config 'configs.mason',
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      {
        'supermaven-inc/supermaven-nvim',
        config = load_config 'configs.supermaven',
      },
    },
    config = load_config 'configs.cmp',
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = load_config 'configs.conform',
  },
}

return {
  plugins = plugins,
  ts_parsers = {
    'bash',
    'css',
    'dart',
    'elixir',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline', -- markdown code blocks
    'python',
    'ruby',
    'rust',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  },
}
