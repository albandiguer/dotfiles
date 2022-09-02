require("todo-comments").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- NOTE override pattern to remove the semicolon and use standard
    highlight = {
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlightng (vim regex)
    },

    search = {
        pattern = [[\b(KEYWORDS)\b]],
    },
})

-- Little hack here, map function is defined in settings.lua, nix concat all files together
map("n", "<Leader>t", ":TodoTrouble<CR>")
