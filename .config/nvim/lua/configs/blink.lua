require("blink.cmp").setup {
  -- Disable for markdown
  enabled = function()
    return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
      and vim.bo.buftype ~= "prompt"
      and vim.b.completion ~= false
  end,

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },

  completion = {
    list = { selection = { preselect = true, auto_insert = true } }, -- 'preselect', 'manual', 'auto_insert'
    accept = { auto_brackets = { enabled = true } },
    menu = {
      auto_show = function(ctx)
        return ctx.mode ~= "cmdline"
      end,
    },
    documentation = { window = { border = "single" } },
  },

  keymap = {
    preset = "enter", -- 'default', 'super-tab', 'enter'
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },

  signature = {
    enabled = true,
    window = { border = "single" },
  },

  snippets = {},

  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },
}
