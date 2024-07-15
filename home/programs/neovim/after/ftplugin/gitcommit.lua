-- conventionalcommits https://github.com/davidsierradz/cmp-conventionalcommits
-- override cmp config so it displays only conventionalcommits cmp source
-- types other than fix: and feat: are allowed, for example @commitlint/config-conventional (based on the Angular convention) recommends build:, chore:, ci:, docs:, style:, refactor:, perf:, test:, and others
require("cmp").setup.buffer({
	sources = require("cmp").config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
})
