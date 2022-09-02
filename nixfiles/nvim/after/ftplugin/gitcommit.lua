-- conventionalcommits https://github.com/davidsierradz/cmp-conventionalcommits
require("cmp").setup.buffer({
	sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
})
