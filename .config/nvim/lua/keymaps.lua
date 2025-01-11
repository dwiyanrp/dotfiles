local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local opts = { noremap = true, silent = true }
local nvchadthemes = require 'nvchad.themes'
local nvchadtabufline = require 'nvchad.tabufline'

-- Modes
-- 'n' -> normal mode | 'v' -> visual mode       | 't' -> terminal mode
-- 'i' -> insert mode | 'x' -> visual block mode | 'c' -> command mode

-- <Esc>
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Use jj as escape
map('i', 'jj', '<Esc>', opts)
map('t', 'JJ', '<C-\\><C-n>', opts)

-- Visual overwrite paste
map({ 'v', 'x' }, 'p', '"_dP', opts)

-- Do not copy on x
map({ 'v', 'x' }, 'x', '"_x', opts)

-- Move to line beginning and end
map({ 'n', 'v', 'x' }, 'gb', '^', { desc = 'Beginning of line' })
map({ 'n', 'v', 'x' }, 'gl', '$', { desc = 'End of line' })

-- Move text up and down
map({ 'v', 'x' }, 'J', ":move '>+1<CR>gv-gv", opts)
map({ 'v', 'x' }, 'K', ":move '<-2<CR>gv-gv", opts)

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Better navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Custom
map('n', '<C-f>', '<cmd>!tmux neww ~/sesh-connect.sh<CR>', { silent = true })
map('n', '<C-d>', '<cmd>qa<CR>')

-- NvChad
map('n', '<leader>th', nvchadthemes.open, { desc = 'Open NvChad themes' })
map('n', '<leader>b', '<cmd>enew<CR>', { desc = 'Open new buffer' })
map('n', '<leader>x', nvchadtabufline.close_buffer, { desc = 'Close current buffer' })
map('n', '<tab>', nvchadtabufline.next, { desc = 'Switch to next buffer' })
map('n', '<S-tab>', nvchadtabufline.prev, { desc = 'Switch to previous buffer' })
