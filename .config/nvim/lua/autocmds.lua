local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd({ 'UIEnter', 'BufReadPost', 'BufNewFile' }, {
  desc = 'user event that loads after UIEnter + only if file buf is there',
  group = vim.api.nvim_create_augroup('NvFilePost', { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })

    if not vim.g.ui_entered and args.event == 'UIEnter' then
      vim.g.ui_entered = true
    end

    if file ~= '' and buftype ~= 'nofile' and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds('User', { pattern = 'FilePost', modeline = false })
      vim.api.nvim_del_augroup_by_name 'NvFilePost'

      vim.schedule(function()
        vim.api.nvim_exec_autocmds('FileType', {})

        if vim.g.editorconfig then
          require('editorconfig').config(args.buf)
        end
      end)
    end
  end,
})

autocmd('VimEnter', {
  desc = 'automatically open the nvim-tree when opening a directory',
  callback = function()
    local is_valid_dir = function(dir)
      return vim.fn.isdirectory(dir) == 1
    end

    -- Check if no arguments were given or if a directory was specified.
    if #vim.fn.argv() == 0 or is_valid_dir(vim.fn.argv()[1]) then
      vim.cmd 'lcd %:p:h'
      require('nvim-tree.api').tree.open()
    end
  end,
})
