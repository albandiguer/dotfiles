return {
  'nickjvandyke/opencode.nvim',
  version = '*',
  dependencies = {
    {
      'folke/snacks.nvim',
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require('opencode').snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local opencode_cmd = 'opencode --port'
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      win = {
        width = 0.55,
        position = 'right',
        enter = false,
        on_win = function(win)
          require('opencode.terminal').setup(win.win)
        end,
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      lsp = { enabled = true },
      server = {
        start = function()
          require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close()
        end,
        toggle = function()
          require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }

    vim.o.autoread = true

    -- README defaults
    vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
      require('opencode').ask('', { submit = true })
    end, { desc = 'Ask opencode' })

    vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action' })

    vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })

    -- Operator motions: go{motion} adds range, goo adds current line
    vim.keymap.set({ 'n', 'x' }, 'go', function()
      return require('opencode').operator '@this '
    end, { expr = true, desc = 'Add range to opencode' })
    vim.keymap.set('n', 'goo', function()
      return require('opencode').operator '@this ' .. '_'
    end, { expr = true, desc = 'Add current line to opencode' })

    -- Scroll (README: <S-C-u> / <S-C-d>)
    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Scroll opencode up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Scroll opencode down' })

    -- Session management (not in README, leader-o namespace)
    vim.keymap.set('n', '<leader>on', function()
      require('opencode').command 'session.new'
    end, { desc = 'New opencode session' })
    vim.keymap.set('n', '<leader>os', function()
      require('opencode').command 'session.select'
    end, { desc = 'Select opencode session' })
    vim.keymap.set('n', '<leader>ol', function()
      require('opencode').command 'session.list'
    end, { desc = 'List opencode sessions' })
    vim.keymap.set('n', '<leader>oi', function()
      require('opencode').command 'session.interrupt'
    end, { desc = 'Interrupt opencode' })
    vim.keymap.set('n', '<leader>ok', function()
      require('opencode').command 'session.compact'
    end, { desc = 'Compact opencode session' })
    vim.keymap.set('n', '<leader>oz', function()
      require('opencode').command 'session.undo'
    end, { desc = 'Undo opencode action' })
    vim.keymap.set('n', '<leader>oZ', function()
      require('opencode').command 'session.redo'
    end, { desc = 'Redo opencode action' })
  end,
}
