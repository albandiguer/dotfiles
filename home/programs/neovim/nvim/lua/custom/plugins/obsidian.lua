return {
  {
    'obsidian-nvim/obsidian.nvim',
    keys = {
      { '<leader>obLn', ':Obsidian link_new<CR>', { noremap = true, silent = true, desc = 'Link New' } },
      { '<leader>obLs', ':Obsidian links<CR>', { noremap = true, silent = true, desc = 'Links' } },
      { '<leader>obT', ':Obsidian TOC<CR>', { noremap = true, silent = true, desc = 'TOC' } },
      { '<leader>obe', ':Obsidian extract_note<CR>', mode = 'v', desc = 'Extract Note' },
      { '<leader>obl', ':Obsidian link<CR>', { noremap = true, silent = true, desc = 'Link' } },
      { '<leader>obn', ':Obsidian unique_note<CR>', { noremap = true, silent = true, desc = 'Unique Note (inbox)' } },
      { '<leader>obo', ':Obsidian open<CR>', { noremap = true, silent = true, desc = 'Open in Desktop app' } },
      { '<leader>obq', ':Obsidian quick_switch<CR>', { noremap = true, silent = true, desc = 'Quick Switch' } },
      { '<leader>obr', ':Obsidian rename<CR>', { noremap = true, silent = true, desc = 'Rename' } },
      { '<leader>obs', ':Obsidian search<CR>', { noremap = true, silent = true, desc = 'Search' } },
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
        {
          name = 'Pretto',
          path = os.getenv 'OBSIDIAN_VAULT_PATH' or '~/Google Drive/obsidian_vaults/Pretto',
        },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        -- folder = "&#128198;" -- 📆
        folder = 'weeklies',
        template = '_assets/templates/daily.md',
      },
      -- Where to put new notes. Valid options are
      -- _ "current_dir" - put new notes in same directory as the current buffer.
      -- _ "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = 'current_dir',

      -- Optional, customize how note IDs are generated (used by extract_note).
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        local usec = vim.loop.gettimeofday()
        local cs = math.floor((usec % 1000000) / 10000)
        return os.date('%Y%m%d%H%M%S') .. string.format('%02d', cs)
      end,

      note_func = function(title)
        local usec = vim.loop.gettimeofday()
        local cs = math.floor((usec % 1000000) / 10000)
        local id = os.date('%Y%m%d%H%M%S') .. string.format('%02d', cs)
        if title and #title > 0 then
          -- Extracted notes: same directory, timestamp filename
          return id .. '.md'
        else
          -- Unique notes: inbox folder, timestamp filename
          return 'inbox/' .. id .. '.md'
        end
      end,

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
