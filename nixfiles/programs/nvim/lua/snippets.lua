local luasnip = require('luasnip')
-- Extend filetypes for ERB to include "html"
luasnip.filetype_extend("ruby", { "rails" })
-- Extend filetypes for ERB to include "html"
luasnip.filetype_extend("eruby", { "html" })
-- below loads friendly-snippets see doc here
-- https://github.com/L3MON4D3/LuaSnip#add-snippets
require("luasnip.loaders.from_vscode").lazy_load()
