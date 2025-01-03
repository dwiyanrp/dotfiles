require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- open from directory
autocmd("BufEnter", {
   callback = function()
      if vim.api.nvim_get_option_value("buftype", {}) ~= "terminal" then
         vim.cmd "lcd %:p:h"
      end
   end,
})
