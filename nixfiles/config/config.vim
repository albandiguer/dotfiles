
colorscheme catppuccin " test https://vimcolorschemes.com/yasukotelin/shirotelin
let g:context_nvim_no_redraw = 1
set mouse=a
set number
set termguicolors
set ignorecase smartcase " search words case insensitive
let mapleader=','
set colorcolumn=80
autocmd Filetype gitcommit setl colorcolumn=72

" disable ex mode
map Q <Nop>

" Copy to system clipboard
map <leader>y "+y
imap <C-l> <space>=>
imap <C-k> <space>->
imap <c-c> <esc>

" vim-dispatch
noremap <leader>d :Dispatch<CR>

" switch previous buffer
nnoremap <leader><leader> <c-^>

" select all
map <C-a> <esc>ggVG<CR>
" awesome paste, lets see
xnoremap p pgvy

" easy lopen lclose
" nmap ( :lopen<CR>
" nmap ) :lclose<CR>
nmap ( :Trouble<CR>
nmap ) :TroubleClose<CR>

" when a bracket is inserted, briefly show the matching one
set showmatch

" disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
" map ctrl hjkl
noremap <c-k> <C-w>k
noremap <c-j> <C-w>j
noremap <c-h> <C-w>h
noremap <c-l> <C-w>l

" Open nerdtree
map <C-n> :NERDTreeToggle<CR>
map <C-b> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
" close vim if only open window is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" FZF config
nmap ; :Buffers<CR>
nmap <Leader>f :GFiles<CR>
nmap <Leader>r :Tags<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
" NOTE disabled as we want to use copilot as well
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra message when using completion
set shortmess+=c

" Ag the silver searcher
" change the default engine for search
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep
	let g:grep_cmd_opts = '--line-numbers --noheading'
	let g:ackprg = 'ag --vimgrep'
	" let g:ackprg = 'ag --nogroup --nocolor --column'
endif"

nnoremap K :Ack! "\b<cword>\b" <CR>

lua << EOF


	local cmp = require'cmp'

	require'nvim-treesitter.configs'.setup {
		-- Modules and its options go here
		highlight = { enable = true },
		incremental_selection = { enable = true },
		textobjects = { enable = true },
		ensure_installed = { "javascript", "lua", "vim", "typescript", "python", "nix", "markdown" }
	}




	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' }, -- For vsnip users.
			{ name = 'copilot' } -- copilot
			-- { name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' }
		}
		)
	})

	-- Setup lspconfig.
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- Register a handler that will be called for all installed servers.
	-- Alternatively, you may also register handlers on specific server instances instead (see example below).

	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workleader_folder, bufopts)
		-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workleader_folder, bufopts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
		end, bufopts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
		-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

		-- VISIT https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#choosing-a-client-for-formatting
		if client.name == "tsserver" then
			-- let null-ls do the formatting
			client.resolved_capabilities.document_formatting = false
		end
	end


	-- The only important thing is to make sure to call require("nvim-lsp-installer").setup {} before interacting with lspconfig
	require("nvim-lsp-installer").setup({
		automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	})

	local lspconfig = require('lspconfig')

	-- Register a handler for the "javascript" language.
	lspconfig.tsserver.setup {
		-- See documentation for the options.
		capabilities = capabilities,
		on_attach = on_attach

	}

	lspconfig.jedi_language_server.setup {
		capabilities = capabilities,
		on_attach = on_attach
	}

	lspconfig.vimls.setup {}
	lspconfig.rnix.setup {}

	-- Async formatting on save callback
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#code-1
	local async_formatting = function(bufnr)
	    bufnr = bufnr or vim.api.nvim_get_current_buf()

	    vim.lsp.buf_request(
		bufnr,
		"textDocument/formatting",
		{ textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
		function(err, res, ctx)
		    if err then
			local err_msg = type(err) == "string" and err or err.message
			-- you can modify the log message / level (or ignore it completely)
			vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
			return
		    end

		    -- don't apply results if buffer is unloaded or has been modified
		    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
			return
		    end

		    if res then
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
			vim.api.nvim_buf_call(bufnr, function()
			    vim.cmd("silent noautocmd update")
			end)
		    end
		end
	    )
	end


	local null_ls = require("null-ls")
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
	null_ls.setup({
	    sources = {
		null_ls.builtins.code_actions.statix,
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.vint,
		null_ls.builtins.formatting.alejandra,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	    },
		debug = false,
		-- Async formatting on save
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
			    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			    vim.api.nvim_create_autocmd("BufWritePost", {
				group = augroup,
				buffer = bufnr,
				callback = function()
				    async_formatting(bufnr)
				end,
			    })
			end
		    end
	})

	require("trouble").setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	})

EOF
