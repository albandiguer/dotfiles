return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    dependencies = {
      {
        'willothy/wezterm.nvim',
        config = true,
      },
    },
    build = ':UpdateRemotePlugins',
    keys = {
      { '<leader>mi', ':MoltenInit<CR>', desc = 'Initialize Molten' },
      { '<leader>me', ':MoltenEvaluateLine<CR>', desc = 'Evaluate Line' },
      { '<leader>mr', ':MoltenReevaluateCell<CR>', desc = 'Reevaluate Cell' },
      { '<leader>md', ':MoltenDelete<CR>', desc = 'Delete Cell' },
      { '<leader>mx', ':MoltenInterrupt<CR>', desc = 'Interrupt Execution' },
      { '<leader>mo', ':MoltenEnterOutput<CR>', desc = 'Enter Output Mode' },
      { '<leader>mh', ':MoltenHideOutput<CR>', desc = 'Hide Output' },
      -- Visual mode mapping
      { '<leader>me', ':<C-u>MoltenEvaluateVisual<CR>', mode = 'v', desc = 'Evaluate Visual Selection' },
    },
    init = function()
      -- Set Python path before plugin loads
      -- vim.g.python3_host_prog = os.getenv('PYTHON_VIRTUALENV') or vim.fn.exepath('python3')
      vim.g.python3_host_prog = vim.fn.expand '~/.virtualenvs/molten/bin/python3'
    end,
    config = function()
      -- Configure plugin after it loads
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_kernel_name = 'python3'
      vim.g.molten_image_provider = 'wezterm'
      vim.g.molten_auto_open_output = false
    end,
  },

  -- important here the extension will work only if jupytext is available
  -- currently installing it in a uv venv, activate that venv before
  -- opening a ipynb file with nvim (see mise). Not great, improve
  {
    'goerz/jupytext.vim',
    ft = { 'ipynb' },
    init = function()
      -- Set up filetype detection before the plugin loads
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '*.ipynb',
        callback = function()
          vim.bo.filetype = 'ipynb'
        end,
      })
    end,
    config = function()
      -- Convert ipynb to markdown when opening
      vim.g.jupytext_fmt = 'md'
      -- Automatically sync the ipynb file when saving the markdown
      vim.g.jupytext_sync_always = 1

      -- Additional settings for better notebook handling
      vim.g.jupytext_filetype_map = {
        ipynb = 'ipynb',
        md = 'markdown',
      }
    end,
  },

  -- TODO: switch for quarto mode ?
}
