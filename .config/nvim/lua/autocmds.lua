require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- automatically open the nvim-tree when opening a directory
autocmd("VimEnter", {
  callback = function()
    local is_valid_dir = function(dir)
      return vim.fn.isdirectory(dir) == 1
    end

    -- Check if no arguments were given or if a directory was specified.
    if #vim.fn.argv() == 0 or is_valid_dir(vim.fn.argv()[1]) then
      require("nvim-tree.api").tree.open()
    end
  end,
})

-- automatically change directory to the file's parent when opening a file
autocmd("BufEnter", {
  callback = function()
    if vim.api.nvim_get_option_value("buftype", {}) ~= "terminal" then
      vim.cmd "lcd %:p:h"
    end
  end,
})
