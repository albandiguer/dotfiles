return {
  'goerz/jupytext.vim',
  ft = { 'ipynb' },
  lazy = false,
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
}
