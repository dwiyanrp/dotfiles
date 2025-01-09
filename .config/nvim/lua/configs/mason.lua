dofile(vim.g.base46_cache .. "mason")

require("mason").setup {
  PATH = "skip",
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  max_concurrent_installers = 10,
}
