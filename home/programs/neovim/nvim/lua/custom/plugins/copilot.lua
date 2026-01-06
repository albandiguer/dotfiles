return { -- Copilot
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    copilot_node_command = vim.fn.expand('~/.local/share/mise/installs/node/latest/bin/node'),
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
