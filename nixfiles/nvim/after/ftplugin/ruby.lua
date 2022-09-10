-- add a buffer variable
-- if !exists("b:count")
-- let b:count = 1
-- else
-- let b:count += 1
-- endif

require("lspconfig").solargraph.setup({}) -- https://solargraph.org/

-- TODO disable formatting as rubocop handles it? whats the solargraph formatter like
