-- conventionalcommits https://github.com/davidsierradz/cmp-conventionalcommits
-- override cmp config so it displays only conventionalcommits cmp source
require("cmp").setup.buffer({
	sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
})
