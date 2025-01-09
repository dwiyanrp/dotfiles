local function load_config(package)
  return function()
    require(package)
  end
end

local completion = "cmp"

local plugins = {
  -- Which Key
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    config = load_config("configs.gitsigns"),
  },

  -- NvimTree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = load_config("configs.nvimtree"),
  },

  -- Telescope & Undo
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "debugloop/telescope-undo.nvim",
    },
    cmd = "Telescope",
    config = load_config("configs.telescope"),
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = load_config("configs.treesitter"),
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = load_config("configs.lspconfig"),
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = load_config("configs.mason"),
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    enabled = completion == "cmp",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",

      -- snippet plugin
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = load_config("configs.luasnip"),
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- supermaven
      {
        "supermaven-inc/supermaven-nvim",
        config = function()
          require("supermaven-nvim").setup {
            keymaps = {
              accept_suggestion = "<C-k>",
              clear_suggestion = "<C-]>",
              accept_word = "<C-j>",
            },
            ignore_filetypes = {},
            disable_inline_completion = false,
            disable_keymaps = false,
            condition = function()
              return false
            end,
            log_level = "info",
          }
        end,
      },
    },
    config = load_config("configs.cmp"),
  },
  {
    "saghen/blink.cmp",
    enabled = completion == "blink",
    event = { "InsertEnter" },
    lazy = false, -- lazy loading handled internally
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- "giuxtaposition/blink-cmp-copilot",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    version = "*", -- use a release tag to download pre-built binaries
    config = load_config("configs.blink"),
    opts_extend = { "sources.default" },
  },

  -- Conform
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = load_config("configs.conform"),
  },

  -- Go
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    keys = {
      { "<leader>gaj", "<cmd>GoAddTag<cr>", desc = "Add json tags" },
      { "<leader>gam", "<cmd>GoAddTag mapstructure<cr>", desc = "Add mapstructure tags" },
      { "<leader>gae", "<cmd>GoAddTag env<cr>", desc = "Add env tags" },
      { "<leader>gay", "<cmd>GoAddTag yaml<cr>", desc = "Add YAML tags" },
      { "<leader>gasvr", "<cmd>GoAddTag validate:required<cr>", desc = "Add Swagger validate required tags" },
      { "<leader>gasvo", "<cmd>GoAddTag validate:optional<cr>", desc = "Add Swagger validate optional tags" },

      { "<leader>gim", "<cmd>GoImplements<cr>", desc = "Find implementations of this method" },
    },
  },
}

local nvchad_plugins = {
  "nvim-lua/plenary.nvim",
  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },
  "nvzone/volt",
  "nvzone/menu",
  {
    "nvzone/minty",
    cmd = { "Huefy", "Shades" },
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    config = function()
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup {
        indent = { char = "│", highlight = "IblChar" },
        scope = { char = "│", highlight = "IblScopeChar" },
      }

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },
}

for _, plugin in ipairs(nvchad_plugins) do
  table.insert(plugins, plugin)
end

return {
  plugins = plugins,
  ts_parsers = {
    "bash",
    "css",
    "dart",
    "elixir",
    "gitcommit",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline", -- markdown code blocks
    "python",
    "ruby",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
}
