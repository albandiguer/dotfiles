local options = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
    end,
}

-- require("lspconfig").sorbet.setup(options)
