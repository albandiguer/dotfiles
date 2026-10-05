return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Languages without a well-standardized style: don't format on save.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = { -- NOTE: add config here when the formatter doesn't come from an LSP
      lua = { 'stylua' },
      -- yaml = { 'yamlfmt' }, -- https://github.com/google/yamlfmt/issues/102
      javascript = { 'prettier' },
      typescript = { 'prettier' }, -- let conform format js/ts; vtsls/ts_ls + prettier is painful
      markdown = { 'prettier' },
      nix = { 'nixfmt' }, -- from Homebrew (see docs/brew-managed-vs-manual.md)
    },
    formatters = {
      prettier = {
        -- Run prettier for markdown always; for other filetypes only when the
        -- project actually uses prettier.
        condition = function()
          if vim.bo.filetype == 'markdown' then
            return true
          end
          local cwd = vim.fn.getcwd()
          for _, name in ipairs {
            '.prettierrc',
            '.prettierrc.js',
            '.prettierrc.json',
            '.prettierrc.yaml',
            'prettier.config.js',
          } do
            if vim.uv.fs_realpath(cwd .. '/' .. name) then
              return true
            end
          end
          local package_json = cwd .. '/package.json'
          if vim.uv.fs_realpath(package_json) then
            local ok, content = pcall(vim.fn.readfile, package_json)
            if ok and content then
              local ok2, pkg = pcall(vim.fn.json_decode, table.concat(content, '\n'))
              if ok2 and pkg then
                return (pkg.dependencies and pkg.dependencies['prettier'] ~= nil) or (pkg.devDependencies and pkg.devDependencies['prettier'] ~= nil)
              end
            end
          end
          return false
        end,
      },
    },
  },
}
