dofile(vim.g.base46_cache .. "git")

require("gitsigns").setup {
  signs = {
    delete = { text = "󰍵" },
    changedelete = { text = "󱕖" },
  },
}
