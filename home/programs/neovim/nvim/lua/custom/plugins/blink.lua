-- blink.cmp: the autocompletion engine (the popup menu you get while typing).
-- It replaces nvim-cmp entirely: it provides LSP/`path`/snippet completion,
-- signature help, and the LSP `capabilities` advertised to servers (see
-- `custom/plugins/lsp.lua`). LuaSnip + friendly-snippets supply the snippets.
return {
  'saghen/blink.cmp',
  optional = true,
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Conventional commit completions in gitcommit buffers
    { 'disrupted/blink-cmp-conventional-commits' },
    -- Snippet engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Needed for regex support in snippets; not supported on Windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            -- require('luasnip.loaders.from_lua').load { paths = '~/.snippets' }
          end,
        },
      },
      opts = {},
    },
    -- dadbod
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    -- See `:help ins-completion` and `:h blink-cmp-config-keymap`.
    keymap = {
      -- 'default': <c-y> to accept, <c-n>/<c-p> to select, <tab>/<s-tab> for snippets.
      preset = 'default',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          -- label and label_description are combined by colorful-menu.nvim.
          columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'source_name' } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },

    sources = {
      default = { 'conventional_commits', 'lsp', 'path', 'snippets', 'lazydev' },
      per_filetype = {
        sql = { 'snippets', 'dadbod', 'buffer' },
      },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        conventional_commits = {
          name = 'Conventional Commits',
          module = 'blink-cmp-conventional-commits',
          enabled = function()
            return vim.bo.filetype == 'gitcommit'
          end,
          ---@module 'blink-cmp-conventional-commits'
          ---@type blink-cmp-conventional-commits.Options
          opts = {},
        },
      },
    },

    snippets = { preset = 'luasnip' },

    -- The Rust matcher is optional; keep the Lua implementation.
    -- See `:h blink-cmp-config-fuzzy`.
    fuzzy = { implementation = 'lua' },

    signature = { enabled = true },
  },
}
