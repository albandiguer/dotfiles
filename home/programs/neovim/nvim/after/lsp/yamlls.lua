-- opts here https://github.com/google/yamlfmt/blob/main/docs/config-file.md#configuration-1
-- https://www.reddit.com/r/neovim/comments/197t7my/question_how_to_configure_yamlls_formatter_with/
return {
  settings = {
    yaml = {
      format = {
        enable = true, -- yamlls format using prettier
      },
    },
  },
}
