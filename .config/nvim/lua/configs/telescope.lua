dofile(vim.g.base46_cache .. 'telescope')

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local map = vim.keymap.set

telescope.setup {
  defaults = {
    prompt_prefix = '   ',
    selection_caret = ' ',
    entry_prefix = ' ',
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ['q'] = require('telescope.actions').close },
    },
  },
  extensions_list = { 'themes', 'terms' },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
    undo = {},
  },
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'undo')

-- See `:help telescope.builtin`
local builtins = {
  fz = function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end,

  live_grep_current_file = function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end,

  nvim_files = function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end,
}

-- telescope find
map('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
map('n', '<leader>fw', builtin.live_grep, { desc = '[F]ind [W]ord' })
map('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
map('n', '<leader>fm', builtin.marks, { desc = '[F]ind [M]arks' })
map('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind [O]ldfiles' })
map('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
map('n', '<leader>fz', builtins.fz, { desc = '[F]uzzy find in current buffer' })
map('n', '<leader>f/', builtins.live_grep_current_file, { desc = '[S]earch [/] in Open Files' })
map('n', '<leader>fn', builtins.nvim_files, { desc = '[S]earch [N]eovim files' })

-- undo
map('n', '<Space>u', ':Telescope undo<CR>')
