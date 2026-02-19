-- https://developer.salesforce.com/docs/platform/sfvscode-extensions/guide/apex-language-server.html
return {
  apex_jar_path = vim.fn.stdpath 'data' .. '/mason/share/apex-language-server/apex-jorje-lsp.jar',
  apex_enable_semantic_errors = true,
}
