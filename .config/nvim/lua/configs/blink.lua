local blink = require 'blink.cmp'
local icons = require 'lib.icons'

blink.setup {
  keymap = {
    preset = 'enter', -- 'default', 'super-tab', 'enter'
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
  },

  -- Disable for markdown
  enabled = function()
    return not vim.tbl_contains({ 'markdown' }, vim.bo.filetype) and vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
  end,

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
    kind_icons = icons.kind,
  },

  completion = {
    list = { selection = { preselect = true, auto_insert = true } }, -- 'preselect', 'manual', 'auto_insert'
    accept = { auto_brackets = { enabled = true } },
    menu = {
      auto_show = function(ctx)
        return ctx.mode ~= 'cmdline'
      end,
    },
    documentation = { window = { border = 'single' } },
  },

  signature = {
    enabled = true,
    window = { border = 'single' },
  },

  snippets = {},

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'copilot' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
      copilot = {
        name = 'copilot',
        module = 'blink-cmp-copilot',
        score_offset = 90,
        async = true,
        transform_items = function(_, items)
          local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
          local kind_idx = #CompletionItemKind + 1
          CompletionItemKind[kind_idx] = 'Copilot'
          for _, item in ipairs(items) do
            item.kind = kind_idx
          end
          return items
        end,
      },
    },
  },
}
