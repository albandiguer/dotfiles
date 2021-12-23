{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    silver-searcher
    # use lorri init in project directories to setup the shell.nix file
    lorri
    nodejs-17_x
    tree
    # fzf
    # fzf-zsh
    nix-prefetch-github
    nixfmt
    roboto-slab # used by AltaCV
    lato # used by AltaCV
    # rnix-lsp
    (nerdfonts.override {
      fonts = [
        # "FiraCode"
        # "DroidSansMono"
        # "Iosevka"
        # "UbuntuMono"
        # "Monofur"
        "FantasqueSansMono"
        "VictorMono"
      ];
    }) # required for devicons
  ];

  programs.mcfly = {
    enable = true;
    enableZshIntegration = true;
  };

  # enable direnv to autostart nix-shell in directories
  # Create a file called .envrc in your project directory.
  # echo use_nix > .envrc
  # use lorri init to start a new config file
  # Then run:
  # direnv allow .
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # shellInit = ''
    #   eval "$(mcfly init zsh)"
    # '';
    plugins = [{
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.4.0";
        sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
      };
    }];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Alban Diguer";
    userEmail = "alban.diguer@gmail.com";
    extraConfig = {
      color.ui = true;
      alias = {
        a = "add";
        aa = "add --all";
        amend = "commit --amend";
        b = "branch";
        br = "branch";
        c = "commit";
        chunkyadd = "add --patch";
        ci = "commit";
        co = "checkout";
        cp = "cherry-pick";
        d = "difftool";
        dc = "difftool --cached";
        l = "log --graph --date=short";
        nb = "checkout -b";
        ps = "push";
        reset = "reset HEAD";
        s = "status";
        shwo = "show";
        st = "status";
      };
      github.user = "albandiguer";
      format.pretty =
        "format:%C(yellow)%h%C(reset) %C(green)%ad%C(reset) %C(blue)%an%C(reset) %s";
      core.excludesfile = ".gitignore";
    };
  };
  # set your user tokens as enivornment variables, such as ~/.secrets
  # See the README for examples.

  programs.neovim = {
    enable = true;
    extraConfig = ''
      colorscheme catppuccin "ayu everforest
      let g:context_nvim_no_redraw = 1
      set mouse=a
      set number
      set termguicolors
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

      set completeopt=menuone,noinsert,noselect

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
      nmap <Leader>b :Buffers<CR>

      " Use <Tab> and <S-Tab> to navigate through popup menu
      inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

      " Set completeopt to have a better completion experience
      set completeopt=menuone,noinsert,noselect

      " Avoid showing message extra message when using completion
      set shortmess+=c

      " ALE syntax checkers
      " let g:ale_completion_delay=200
      let g:ale_completion_enabled = 0
      let g:ale_echo_cursor = 0 " fasten things a lot (see vim profile)
      let g:ale_echo_msg_error_str = 'E'
      let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
      let g:ale_echo_msg_warning_str = 'W'
      let g:ale_fix_on_save = 1
      let g:ale_javascript_prettier_options = '--no-semi --single-quote'
      let g:ale_javascript_prettier_use_local_config = 1
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
      let g:ale_linters = {
            \ 'javascript': ['eslint'],
            \ 'typescript': ['tsserver', 'tslint'],
            \ 'nix': ['nix'],
            \ 'python': ['flake8'],
            \ 'sql': ['sqlint'],
            \ 'terraform': ['tflint'],
            \ 'rust': ['rustc']
            \ }
      let g:ale_fixers = {
            \ 'javascript': ['eslint'],
            \ 'typescript': ['prettier'],
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
            \ '*': ['remove_trailing_lines', 'trim_whitespace']
            \ }
      let g:ale_python_black_options = '--line-length 78' " line length 88 by default
      " TODO look into COC/ALE integration, https://github.com/dense-analysis/ale#faq-coc-nvim
      let g:ale_disable_lsp = 1

      " https://github.com/ms-jpq/chadtree/issues/110
      let g:coq_settings = {'xdg': v:true}

      " TrySolve the parse buffer issue
      " let g:prettier#config#single_quote = 'true'
      " let g:prettier#config#trailing_comma = 'all'

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
        -- run :LspInstall <lsp> in vim to install them
        require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
        require'lspconfig'.texlab.setup{on_attach=require'completion'.on_attach}
        require'lspconfig'.tailwindcss.setup{on_attach=require'completion'.on_attach}


        require'nvim-treesitter.configs'.setup {
          -- Modules and its options go here
          highlight = { enable = true },
          incremental_selection = { enable = true },
          textobjects = { enable = true },
        }

        local lsp_installer = require("nvim-lsp-installer")

        -- Register a handler that will be called for all installed servers.
        -- Alternatively, you may also register handlers on specific server instances instead (see example below).
        lsp_installer.on_server_ready(function(server)
            local opts = {}

            -- (optional) Customize the options passed to the server
            -- if server.name == "tsserver" then
            --     opts.root_dir = function() ... end
            -- end

            -- This setup() function is exactly the same as lspconfig's setup function.
            -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            server:setup(opts)
        end)
      EOF
    '';

    # install needed binaries here
    extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
      tree-sitter

      # nodePackages.lehre
      # python38Packages.python-language-server
      # python38Packages.black
      # python38Packages.flake8
      # python38Packages
      python38Packages.virtualenv

      # installs different language servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.prettier
      nodePackages.eslint

      elmPackages.elm-format
      # rust-analyzer
      # haskellPackages.brittany
    ];

    plugins = with pkgs.vimPlugins;
      let
        context-vim = pkgs.vimUtils.buildVimPlugin {
          name = "context-vim";
          src = pkgs.fetchFromGitHub {
            owner = "wellle";
            repo = "context.vim";
            rev = "e38496f1eb5bb52b1022e5c1f694e9be61c3714c";
            sha256 = "1iy614py9qz4rwk9p4pr1ci0m1lvxil0xiv3ymqzhqrw5l55n346";
          };
        };

        everforest-vim = pkgs.vimUtils.buildVimPlugin {
          name = "everforest-vim";
          src = pkgs.fetchFromGitHub {
            owner = "sainnhe";
            repo = " everforest";
            rev = "0a3f030f02e9438f834b2775aad00499d0ce6098";
            sha256 = "1nzbaq29as8g4vakd2cnbqfrlf8pwbpid034994013qb8vl7ksq9";
            fetchSubmodules = true;
          };
        };

        aylin-vim = pkgs.vimUtils.buildVimPlugin {
          name = "aylin-vim";
          src = pkgs.fetchFromGitHub {
            owner = "AhmedAbdulrahman";
            repo = "aylin.vim";
            rev = "e4b2ad31d2bfad16fbe792d00180ac3d6888da7a";
            sha256 = "1qc6dysg8jscb6rjcga45pbzv0hyi39pc010qk5gy1hvnm3qyhgn";
            fetchSubmodules = true;
          };
        };

        catppuccin-vim = pkgs.vimUtils.buildVimPlugin {
          name = "catppuccin-vim";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "nvim";
            rev = "22b34eb9f93430bc010dee1523743b62cd2700fc";
            sha256 = "1cqc6pws6czdshzxmh89ryf2j1cc2n5maf8v5v6nh8yw02jqghk5";
            fetchSubmodules = true;
          };
        };

        nvim-lsp-installer = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-lsp-installer";
          src = pkgs.fetchFromGitHub {
            owner = "williamboman";
            repo = "nvim-lsp-installer";
            rev = "81125c9d4c076f55dab58c0ec2e282412767d134";
            sha256 = "1mkg3rwwkmgr06nyr98gjfrxf3yw4xwjwdb8yg383kijx4sxvjql";
            fetchSubmodules = true;
          };
        };

        nvim-coq = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-coq";
          src = pkgs.fetchFromGitHub {
            owner = "ms-jpq";
            repo = "coq_nvim";
            rev = "f158c34b1796a5afa9836b2005385402d14d7156";
            sha256 = "1a9vmk9cwlaawq4p1gkfjgznahj5g807ppb0s2w38fv3rbyb155z";
            fetchSubmodules = true;
          };
        };

        # zenbones-nvim = pkgs.vimUtils.buildVimPlugin {
        #   name = "zenbones-vim";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "mcchrish";
        #     repo = "zenbones.nvim";
        #     rev = "fdf17ce3ddd0ea637be86450347d9988d74e6a65";
        #     sha256 = "14n2d5vc51rh3dzk4l7h75dcr3a11vja4zvyq8qng0cacy8ds0ph";
        #     fetchSubmodules = true;
        #   };
        # };
        # use nix-prefetch-github to finc dets
        # papaya-vim = pkgs.vimUtils.buildVimPlugin {
        #   name = "vim-theme-papaya";
        #   src = pkgs.fetchFromGitHub {
        #     owner= "HenryNewcomer";
        #     repo= "vim-theme-papaya";
        #     rev= "dcb18be55215f44418d75b6f071773f80ed87caa";
        #     sha256= "1rway5wyyqmzjrjmbpvd6h7flfkrmydcj6r6i7x609dplx9yhy7w";
        #     fetchSubmodules= true;
        #   };
        # };
      in [
        # papaya-vim
        # vim-theme-papaya
        ack-vim
        ale
        aylin-vim
        ayu-vim
        catppuccin-vim
        # completion-nvim # no longer maintained, switch to something better like coq_nvim
        nvim-coq
        context-vim
        delimitMate
        editorconfig-vim
        everforest-vim
        fzf-vim
        gruvbox-community
        nerdtree
        nvim-lspconfig
        nvim-lsp-installer
        nvim-treesitter
        copilot-vim
        # tabnine-vim
        tabular
        vim-airline
        vim-better-whitespace
        vim-commentary
        vim-devicons
        vim-dispatch
        vim-fugitive
        vim-gist
        vim-nix
        vim-prettier
        vim-slash
        webapi-vim # used by vim-gist for api call
        # zenbones-nvim
        vim-jsdoc

        # or you can use our function to directly fetch plugins from git
        # (plugin "schickling/vim-bufonly")

      ]; # Only loaded if programs.neovim.extraConfig is set
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "albandiguer";
  home.homeDirectory = "/Users/albandiguer";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}