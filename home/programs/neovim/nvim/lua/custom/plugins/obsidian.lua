return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    opts = {
      workspaces = {
        {
          name = 'Reliable Brain',
          path = '~/Google Drive/obsidian_vaults/Reliable Brain',
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        -- folder = "&#128198;" -- 📆
        folder = '📆/%Y',
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- see below for full list of options 👇
    },
  },
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
}
