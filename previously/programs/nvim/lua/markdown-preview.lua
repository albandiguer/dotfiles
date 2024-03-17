-- set to 1, nvim will open the preview window after entering the markdown buffer
vim.g.mkdp_auto_start = 0

-- set to 1, the nvim will auto close current preview window when change from markdown buffer to another buffer
vim.g.mkdp_auto_close = 1

-- disable sync scroll
vim.g.mkdp_preview_options = { disable_sync_scroll = 1 }

-- theme
vim.g.mkdp_theme = 'light'
