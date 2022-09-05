local luasnip = require('luasnip')
luasnip.filetype_extend("ruby", { "rails" })
-- below loads friendly-snippets see doc here
-- https://github.com/L3MON4D3/LuaSnip#add-snippets
require("luasnip.loaders.from_vscode").lazy_load()
