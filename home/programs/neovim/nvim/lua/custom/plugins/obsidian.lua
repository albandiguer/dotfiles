return {
  {
    'obsidian-nvim/obsidian.nvim',
    keys = {
      { '<leader>oLn', ':Obsidian link_new<CR>', { noremap = true, silent = true, desc = 'Link New' } },
      { '<leader>oLs', ':Obsidian links<CR>', { noremap = true, silent = true, desc = 'Links' } },
      { '<leader>oT', ':Obsidian TOC<CR>', { noremap = true, silent = true, desc = 'TOC' } },
      { '<leader>oc', ':Obsidian toggle_checkbox<CR>', { noremap = true, silent = true, desc = 'Toggle Checkbox' } },
      { '<leader>od', ':Obsidian dailies<CR>', { noremap = true, silent = true, desc = 'Dailies' } },
      { '<leader>oe', ':Obsidian extract_note<CR>', { noremap = true, silent = true, desc = 'Extract Note' } },
      { '<leader>of', ':Obsidian new_from_template<CR>', { noremap = true, silent = true, desc = 'New From Template' } },
      { '<leader>ol', ':Obsidian link<CR>', { noremap = true, silent = true, desc = 'Link' } },
      { '<leader>on', ':Obsidian new<CR>', { noremap = true, silent = true, desc = 'New' } },
      { '<leader>oo', ':Obsidian open<CR>', { noremap = true, silent = true, desc = 'Open in Desktop app' } },
      { '<leader>oq', ':Obsidian quick_switch<CR>', { noremap = true, silent = true, desc = 'Quick Switch' } },
      { '<leader>or', ':Obsidian rename<CR>', { noremap = true, silent = true, desc = 'Rename' } },
      { '<leader>os', ':Obsidian search<CR>', { noremap = true, silent = true, desc = 'Search' } },
      { '<leader>ot', ':Obsidian today<CR>', { noremap = true, silent = true, desc = 'Today' } },
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
        folder = 'diary 📔',
        template = '_assets/templates/daily.md',
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
      new_notes_location = 'notes_subdir',

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
        -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. '-' .. suffix
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
