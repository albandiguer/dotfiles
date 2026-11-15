-- GitHub Copilot AI completion (replaces Codeium/Windsurf, sunset Nov 2025).
-- Virtual-text suggestions only, no completion source: blink.cmp stays as-is.
-- Auth once with `:Copilot auth`; NES accept is `<leader>cn`.
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  dependencies = {
    -- Next edit suggestions (NES), the closest thing to Windsurf supercomplete.
    'copilotlsp-nvim/copilot-lsp',
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },
  config = function()
    require('copilot').setup {
      -- Server comes from nix (`copilot-language-server`), no runtime download.
      server = { type = 'binary', custom_server_filepath = 'copilot-language-server' },
      nes = {
        enabled = true,
        keymap = { accept_and_goto = '<leader>cn', accept = false, dismiss = '<Esc>' },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = false,
        },
      },
    }
  end,
}
