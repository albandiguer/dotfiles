return {
  {
    'epwalsh/obsidian.nvim',
    keys = {
      { '<leader>os', ':ObsidianSearch<CR>', { noremap = true, silent = true, desc = 'Obsidian Search' } },
      { '<leader>oo', ':ObsidianOpen<CR>', { noremap = true, silent = true, desc = 'Obsidian Open' } },
      { '<leader>od', ':ObsidianDailies<CR>', { noremap = true, silent = true, desc = 'Obsidian Dailies' } },
      { '<leader>ot', ':ObsidianToday<CR>', { noremap = true, silent = true, desc = 'Obsidian Today' } },
    },
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = false,
    enabled = true,
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
          path = os.getenv 'OBSIDIAN_VAULT_PATH' or '~/Google Drive/obsidian_vaults/Reliable Brain',
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        -- folder = "&#128198;" -- 📆
        folder = '📆/',
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      templates = {
        folder = '_config/templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      ui = {
        external_link_icon = { char = '📎', hl_group = 'ObsidianExtLinkIcon' }, -- characters to use as the icon for external links
      },

      -- see below for full list of options 👇
    },
  },
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
}
