return {
  -- Configure Lua LSP for the Neovim config / runtime / plugins.
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Main LSP configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason must be set up before its dependents.
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Status updates for LSP
      'j-hui/fidget.nvim',

      -- Completion capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Give every server blink's LSP capabilities (completion / snippets).
      -- `after/lsp/<name>.lua` still overrides per server.
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- Runs for every buffer an LSP attaches to.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Highlight references of the word under the cursor while it rests there.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints when the server supports them.
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- See `:help vim.diagnostic.Opts`
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      -- Tools (LSP servers + formatters/linters) installed by Mason.
      -- Server overrides live in `after/lsp/<name>.lua`; most settings are on
      -- https://luals.github.io/wiki/settings/ etc.
      -- Run `:Mason` to inspect / manually install.
      local ensure_installed = {
        'bashls',
        'cssls',
        'docker_compose_language_service',
        'dockerls',
        'herb_ls',
        'html',
        'jsonls',
        'fish_lsp',
        'latexindent',
        'lua_ls',
        'marksman',
        'nil_ls', -- nix lsp
        -- 'nixfmt', -- nil_ls has no default fmt; nixfmt unsupported on macos -> brew
        'prettier',
        'proselint',
        'ruff', -- python linter & formatter https://docs.astral.sh/
        'shellcheck',
        'shfmt',
        -- 'snyk-ls',
        'stimulus_ls',
        'stylua', -- luals formatting is mid
        'tailwindcss',
        -- 'terraformls', -- NOTE: broken for now
        'texlab',
        'tflint',
        'tombi', -- toml
        'ty', -- python static analyzer https://docs.astral.sh/
        'vtsls', -- handle typescript in .vue files
        'vue-language-server', -- handle html+css in .vue files
        'yamlfmt',
        'yamlls',
      }
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- installs are handled by mason-tool-installer
        automatic_installation = false,
        automatic_enable = true,
      }
    end,
  },
}
