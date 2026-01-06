-- Always use Mason's vtsls with its bundled Node.js
-- This ensures vtsls is isolated from project Node.js versions

local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin/vtsls'

return {
  cmd = { mason_bin, '--stdio' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
}
