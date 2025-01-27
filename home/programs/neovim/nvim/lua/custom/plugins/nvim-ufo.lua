return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  event = 'BufReadPost', -- load after buffer is loaded
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      -- Liste des filetypes à exclure
      local exclude_ft = {
        ['nvimtree'] = true,
        ['neo-tree'] = true,
        ['dbui'] = true,
        ['aerial'] = true,
        ['undotree'] = true,
        ['terminal'] = true,
      }

      if exclude_ft[filetype] then
        return ''
      end
      return { 'treesitter', 'indent' }
    end,
    -- Use nice folding symbols
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ('  %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end,
  },
  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
      desc = 'Open all folds',
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
      desc = 'Close all folds',
    },
    {
      'zr',
      function()
        require('ufo').openFoldsExceptKinds()
      end,
      desc = 'Open folds except kinds',
    },
    {
      'zm',
      function()
        require('ufo').closeFoldsWith()
      end,
      desc = 'Close folds with',
    },
    {
      'zp',
      function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      desc = 'Peek fold or hover',
    },
  },
  config = function(_, opts)
    -- Configuration nécessaire pour une meilleure expérience
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require('ufo').setup(opts)
  end,
}
