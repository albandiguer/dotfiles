return {
  {
    'obsidian-nvim/obsidian.nvim',
    keys = {
      { '<leader>od', ':Obsidian dailies<CR>', { noremap = true, silent = true, desc = 'ObsidianDailies' } },
      { '<leader>oen', ':Obsidian extract_note<CR>', { noremap = true, silent = true, desc = 'ObsidianExtractNote' } },
      { '<leader>on', ':Obsidian new<CR>', { noremap = true, silent = true, desc = 'ObsidianNew' } },
      { '<leader>ont', ':Obsidian new_from_template<CR>', { noremap = true, silent = true, desc = 'ObsidianNewFromTemplate' } },
      { '<leader>oo', ':Obsidian open<CR>', { noremap = true, silent = true, desc = 'ObsidianOpen' } },
      { '<leader>os', ':Obsidian search<CR>', { noremap = true, silent = true, desc = 'ObsidianSearch' } },
      { '<leader>ot', ':Obsidian today<CR>', { noremap = true, silent = true, desc = 'ObsidianToday' } },
      { '<leader>otc', ':Obsidian toggle_checkbox<CR>', { noremap = true, silent = true, desc = 'ObsidianToggleCheckbox' } },
    },
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
      legacy_commands = false, -- use legacy commands, e.g. `:Obsidian today` instead of `:ObsidianToday`
      workspaces = {
        {
          name = 'Reliable Brain',
          path = os.getenv 'OBSIDIAN_VAULT_PATH' or '~/Google Drive/obsidian_vaults/Reliable Brain',
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        -- folder = "&#128198;" -- 📆
        folder = 'Fleeting/',
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        blink = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- Where to put new notes. Valid options are
      -- _ "current_dir" - put new notes in same directory as the current buffer.
      -- _ "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = 'Fleeting/',

      templates = {
        folder = '_assets/templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      ui = {
        enable = false,
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
