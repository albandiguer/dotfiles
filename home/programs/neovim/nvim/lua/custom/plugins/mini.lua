return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects: va) / yinq / ci'
    require('mini.ai').setup {
      n_lines = 500,
      mappings = {
        -- Disable next/last text objects; Neovim has built-in treesitter
        -- incremental selection.
        around_next = '',
        inside_next = '',
        around_last = '',
        inside_last = '',
      },
    }

    -- Move selections around
    require('mini.move').setup {}

    -- Highlight cursor word
    require('mini.cursorword').setup {}

    -- Add/delete/replace surroundings: saiw) / sd' / sr)'
    require('mini.surround').setup()

    -- Statusline
    local statusline = require 'mini.statusline'
    statusline.setup {
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
          local diff = statusline.section_diff { trunc_width = 75 }
          local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
          local lsp = statusline.section_lsp { trunc_width = 75 }
          local filename = statusline.section_filename { trunc_width = 140 }
          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
          local location = statusline.section_location()
          local search = statusline.section_searchcount { trunc_width = 75 }

          local opencode_ok, opencode = pcall(require, 'opencode')
          local opencode_status = opencode_ok and opencode.statusline() or ''

          return statusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { diff, diagnostics, lsp } },
            '%<', -- truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- end left alignment
            { hl = 'MiniStatuslineDevinfo', strings = { opencode_status } },
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
      },
    }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- nvim-tree draws its own UI
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'NvimTree',
      callback = function()
        vim.b.ministatusline_disable = true
      end,
    })
  end,
}
