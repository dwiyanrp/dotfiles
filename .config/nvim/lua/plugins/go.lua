return {
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

      { "<leader>gim", "<cmd>GoImplements<cr>", desc = "Find implementions of this method" },
    },
  },
}
