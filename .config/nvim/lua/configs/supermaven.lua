local supermaven = require 'supermaven-nvim'

supermaven.setup {
  keymaps = {
    accept_suggestion = '<C-k>',
    clear_suggestion = '<C-]>',
    accept_word = '<C-j>',
  },
  ignore_filetypes = {},
  disable_inline_completion = false,
  disable_keymaps = false,
  condition = function()
    return false
  end,
  log_level = 'info',
}
