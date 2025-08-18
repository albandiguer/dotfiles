return {
  -- disable checks for .env https://github.com/LazyVim/LazyVim/discussions/4027#discussioncomment-10425524
  -- FIXME:
  handlers = {
    ['textDocument/publishDiagnostics'] = function(err, res, ...)
      local file_name = vim.fn.fnamemodify(vim.uri_to_fname(res.uri), ':t')
      if string.match(file_name, '^%.env') == nil then
        return vim.lsp.diagnostic.on_publish_diagnostics(err, res, ...)
      end
    end,
  },
}
