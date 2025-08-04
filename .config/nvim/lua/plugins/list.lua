local function load_config(package)
  return function()
    require(package)
  end
end

-- NOTE: Here is where you install your plugins.
local plugins = {
  { -- NvChad
    'nvim-lua/plenary.nvim',

    {
      'nvchad/base46',
      lazy = true,
      build = function()
        require('base46').load_all_highlights()
      end,
    },

    {
      'nvchad/ui',
      config = function()
        require 'nvchad'
      end,
    },

    'nvchad/volt',
    'nvzone/menu',
    { 'nvzone/minty', cmd = { 'Huefy', 'Shades' } },

    {
      'nvim-tree/nvim-web-devicons',
      opts = function()
        dofile(vim.g.base46_cache .. 'devicons')
        return { override = require 'nvchad.icons.devicons' }
      end,
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'User FilePost',
    opts = {
      indent = { char = '│', highlight = 'IblChar' },
      scope = { char = '│', highlight = 'IblScopeChar' },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. 'blankline')

      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require('ibl').setup(opts)

      dofile(vim.g.base46_cache .. 'blankline')
    end,
  },

  -- file managing , picker etc
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = load_config 'configs.nvimtree',
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = require 'opts.whichkey',
  },

  -- formatting!
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = load_config 'configs.conform',
  },

  -- git stuff
  {
    'lewis6991/gitsigns.nvim',
    config = load_config 'configs.gitsigns',
  },

  -- LSP Plugins
  {
    'mason-org/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
    config = load_config 'configs.mason',
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'j-hui/fidget.nvim', opts = {} },
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      require('configs.lspconfig').defaults()
    end,
  },
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
    },
    config = load_config 'configs.cmp',
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

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    opts = function()
      return require 'opts.treesitter'
    end,
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

return {
  plugins = plugins,
}
