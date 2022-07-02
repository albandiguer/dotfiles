
colorscheme catppuccin " test https://vimcolorschemes.com/yasukotelin/shirotelin
let g:context_nvim_no_redraw = 1
set mouse=a
set number
set termguicolors
set ignorecase smartcase " search words case insensitive
let mapleader=","
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
nmap ( :lopen<CR>
nmap ) :lclose<CR>

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

" ALE syntax checkers
" TODO try https://github.com/jose-elias-alvarez/null-ls.nvim as a replacement
" so it integrates with lsp
" let g:ale_completion_delay=200
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1 " https://github.com/dense-analysis/ale#5xxii-how-can-i-use-ale-and-vim-lsp-together
let g:ale_echo_cursor = 0 " fasten things a lot
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 200 " (in ms)
let g:ale_lint_on_enter = 0 " on opening a file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_open_list=0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠ '
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_javascript_prettier_options = '--no-semi --single-quote'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_python_black_options = '--line-length 78' " line length 88 by default

let g:ale_linters = {
			\ 'javascript': ['eslint'],
			\ 'typescript': ['tsserver'],
			\ 'typescriptreact': ['deno'],
			\ 'nix': ['nix'],
			\ 'python': ['flake8'],
			\ 'sql': ['sqlint'],
			\ 'terraform': ['tflint'],
			\ 'rust': ['rustc']
			\ }
let g:ale_fixers = {
			\ 'javascript': ['eslint', 'prettier'],
			\ 'typescript': ['deno', 'prettier'],
			\ 'typescriptreact': ['deno', 'prettier'],
			\ 'html': ['prettier'],
			\ 'markdown': ['prettier'],
			\ 'haskell': ['brittany'],
			\ 'python': ['black'],
			\ 'sql': ['sqlfmt'],
			\ 'elm': ['elm-format'],
			\ 'terraform': ['terraform'],
			\ 'nix': ['nixfmt'],
			\ 'json': ['prettier'],
			\ 'rust': ['rustfmt'],
			\ 'latex': ['latexindent'],
			\ '*': ['remove_trailing_lines', 'trim_whitespace']
			\ }

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


	-- local lspconfig = require('lspconfig')
	local cmp = require'cmp'
	-- run :LspInstall <lsp> in vim to install servers

	-- previously we were doing, no lazy loading
	-- lspconfig.tsserver.setup{on_attach=require'completion'.on_attach}


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
	local nvim_lsp = require('lspconfig')

	-- Register a handler for the "javascript" language.
	nvim_lsp.tsserver.setup {
		-- See documentation for the options.
		capabilities = capabilities,
		on_attach = function(client)
			-- Call initialize() on the client.
			-- This will load the language server and then trigger
			-- the on_attach callback for the client.
			require'completion'.on_attach(client)
		end,
	}


	-- Register a handler for the "deno" language.
	nvim_lsp.deno.setup {
		on_attach = function(client)
			-- Enable completion and hover for the "deno" language.
			vim.lsp.callbacks.on_attach(client, nil, capabilities)
		end,
		capabilities = capabilities,
		settings = {
			deno = {
				completion = {
					enable = true,
				},
				definition = {
					enable = true,
				},
				hover = {
					enable = true,
				},
				references = {
					enable = true,
				},
				rename = {
					enable = true,
				},
				signatureHelp = {
					enable = true,
				},
				typeDefinition = {
					enable = true,
				},
			},
		},
	}

	require("nvim-lsp-installer").setup({
		capabilities = capabilities,
		automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗"
			}
		}
	})

EOF

" Disable diagnostic from neovim built in lsp, ALE does the job
autocmd BufEnter * lua vim.diagnostic.disable()
