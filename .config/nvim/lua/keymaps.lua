local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end
local opts = { noremap = true, silent = true }

-- Modes
-- 'n' -> normal mode | 'v' -> visual mode       | 't' -> terminal mode
-- 'i' -> insert mode | 'x' -> visual block mode | 'c' -> command mode

-- Use jj as escape
map("i", "jj", "<Esc>", opts)
map("t", "JJ", "<C-\\><C-n>", opts)

-- Visual overwrite paste
map({ "v", "x" }, "p", '"_dP', opts)

-- Do not copy on x
map({ "v", "x" }, "x", '"_x', opts)

-- Move to line beginning and end
map({ "n", "v", "x" }, "gb", "^", { desc = "Beginning of line" })
map({ "n", "v", "x" }, "gl", "$", { desc = "End of line" })

-- Move text up and down
map({ "v", "x" }, "J", ":move '>+1<CR>gv-gv", opts)
map({ "v", "x" }, "K", ":move '<-2<CR>gv-gv", opts)

-- Clear search, diff update and redraw
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Consistent n/N search navigation
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Tabufline (nvhad)
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Open new buffer new" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close buffer" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Switch to next buffer" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Switch to previous buffer" })

-- Comment (nvchad)
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- NvCheatsheet (nvchad)
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Open NvCheatsheet" })

-- NvChad Themes (nvchad)
map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "Open NvChad themes" })
