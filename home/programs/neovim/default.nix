{
  config,
  pkgs,
  ...
}: {
  # Lua files for neovim need to be in :h runtimepath
  # https://github.com/nix-community/home-manager/issues/1834
  # https://hhoeflin.github.io/nix/home_folder_nix/
  # https://teu5us.github.io/nix-lib.html
  # type :rtp in neovim to understand this
  home.file."${config.xdg.configHome}/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  # Hacky thing here
  home.file."${config.xdg.configHome}/nvim/lua/main.lua".text = builtins.concatStringsSep "\n" [
    (builtins.readFile nvim/lua/settings.lua)
    (builtins.readFile nvim/lua/treesitter.lua)

    # (builtins.readFile nvim/lua/obsidian.lua)
    (builtins.readFile nvim/lua/cmp.lua)
    (builtins.readFile nvim/lua/devdocs.lua)
    # (builtins.readFile nvim/lua/lazy.lua)
    (builtins.readFile nvim/lua/lspconfig.lua)
    (builtins.readFile nvim/lua/lualine.lua)
    (builtins.readFile nvim/lua/markdown-preview.lua)
    (builtins.readFile nvim/lua/neoai.lua)
    (builtins.readFile nvim/lua/neogen.lua)
    (builtins.readFile nvim/lua/null-ls.lua)
    (builtins.readFile nvim/lua/nvim-notify.lua)
    (builtins.readFile nvim/lua/nvim-tree.lua)
    (builtins.readFile nvim/lua/snippets.lua)
    (builtins.readFile nvim/lua/telescope.lua)
    (builtins.readFile nvim/lua/todo-comments.lua)
    (builtins.readFile nvim/lua/trouble.lua)
    (builtins.readFile nvim/lua/vim-dispatch.lua)
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = builtins.readFile ./init.vim;

    # Enable Python 3 provider.
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.withPython3
    # https://neovim.io/doc/user/provider.html
    # withPython3 = true; # default is true so this redundant
    # Plugins for python3 provider:
    # extraPython3Packages = ps:
    # with ps; [
    # black # not working for null-ls, require it in extraPackages
    # flake8
    # ];

    withRuby = false; # See README for dets

    # generatedConfigs thats where we would set things like nvchad

    # withNodeJs = true; no extraNodePackages to do the same as above with python?

    # Extra packages available to nvim
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.extraPackages
    extraPackages = with pkgs; [
      # bash-language-server
      # docker-compose-language-service
      # elmPackages.elm-format
      # haskellPackages.brittany
      # nixfmt
      # nodePackages_latest.sql-language-server
      # rubocop
      # ruby-lsp
      # rust-analyzer
      # rustfmt
      # solargraph
      # stylua => sumneko does it all now, has a formatter etc
      # texlive.combined.scheme-full
      # tree-sitter-grammars.tree-sitter-python
      alejandra # nix code formatter
      buf-language-server # buf
      cmake-format
      commitlint
      fd # Telescope deps
      gcc # to compile tree-sitter grammar
      hadolint # docker linter # NOTE currently broken
      nil # nix lang server
      nodePackages_latest.bash-language-server
      nodePackages_latest.dockerfile-language-server-nodejs
      nodePackages_latest.eslint
      nodePackages_latest.prettier
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-langservers-extracted #html css json eslint
      nodePackages_latest.yaml-language-server
      pgformatter # https://github.com/darold/pgFormatter
      postgresql # dadbod deps
      pyright
      python312Packages.black # python fmt
      python312Packages.flake8
      redis # dadbod deps
      ripgrep # used by obsidian nvim
      rubyPackages.erb-formatter
      rubyPackages.htmlbeautifier
      shfmt # shell script formatter;
      sqls
      statix # nix lints
      sumneko-lua-language-server # lua
      tailwindcss-language-server # tailwind lsp
      terraform # for terraform_fmt
      terraform-ls
      tree-sitter
      universal-ctags
      vim-vint # for vimscripts
      wget # used by lsp-installer , use :checkhealth in vim
    ];

    plugins = with pkgs.vimPlugins; let
      # can simplify with flake (avoid sha resolution) ?
      # https://www.reddit.com/r/NixOS/comments/mvk5l9/comment/gvqfag9/?utm_source=share&utm_medium=web2x&context=3
      #
      nvim-grb256 = pkgs.vimUtils.buildVimPlugin {
        name = "nvim-grb256";
        src = pkgs.fetchFromGitHub {
          owner = "quanganhdo";
          repo = "grb256";
          rev = "3115044059b3adcd12ea525994de6a255a8bf783";
          sha256 = "G5XG/4IuKZhbPR0JMpUjmctP5WPK7YwdR+WytNYcI2k=";
          fetchSubmodules = false;
        };
      };

      # TODO add theme owickstrom/vim-colors-paramount
      vim-colors-paramount = pkgs.vimUtils.buildVimPlugin {
        name = "vim-colors-paramount";
        src = pkgs.fetchFromGitHub {
          owner = "owickstrom";
          repo = "vim-colors-paramount";
          rev = "a5601d36fb6932e8d1a6f8b37b179a99b1456798";
          sha256 = "sha256-j9nMjKYK7bqrGHprYp0ddLEWs1CNMudxXD13sOROVmY=";
          fetchSubmodules = true;
        };
      };

      neoai-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "neoai-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "Bryley";
          repo = "neoai.nvim";
          rev = "248c2001d0b24e58049eeb6884a79860923cfe13";
          sha256 = "haO7Qi2szWfTxWcknI7aJSKamQ/n6qIhIOxaO544IDY=";
          fetchSubmodules = true;
        };
      };

      nvim-devdocs = pkgs.vimUtils.buildVimPlugin {
        name = "nvim-devdocs";
        src = pkgs.fetchFromGitHub {
          owner = "luckasRanarison";
          repo = "nvim-devdocs";
          rev = "e3da040acc8d6d0b87af6521315b95c6689c8bee";
          sha256 = "sha256-8Wze4iiOIZymRZNnH+GLJxm4ld7i1dj571hfuIw5ltk=";
          fetchSubmodules = false;
        };
      };

      nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
    in [
      # (plugin " schickling/vim-bufonly ") function to directly fetch plugins from git
      # SchemaStore-nvim TODO
      # feat chatgpt?
      # lspcontainers-nvim
      # spaceduck-nvim
      # vim-jsdoc # ftplugin? NOTE: redundant with neogen?
      # vim-vsnip
      ack-vim
      catppuccin-nvim
      cmp-buffer # nvim-cmp source for buffer words.
      cmp-cmdline # nvim-cmp source for command line
      cmp-conventionalcommits
      cmp-copilot
      cmp-git
      cmp-nvim-lsp # nvim-cmp source for neovim's built-in language server client.
      cmp-path
      cmp_luasnip
      delimitMate
      editorconfig-nvim
      friendly-snippets
      jellybeans-vim
      kanagawa-nvim
      lazy-nvim
      lspkind-nvim
      lualine-nvim
      luasnip
      markdown-preview-nvim
      melange-nvim
      neoai-nvim
      neogen
      nui-nvim # required by neoAI https://github.com/Bryley/neoai.nvim
      none-ls-nvim # long live null-ls
      nvim-cmp
      nvim-devdocs
      nvim-grb256
      nvim-lspconfig
      nvim-notify
      nvim-tree-lua
      nvim-treesitter-context
      nvim-treesitter-with-plugins
      nvim-web-devicons
      obsidian-nvim
      plenary-nvim #dep for nvim-devdocs (async programming with coroutines)
      rose-pine
      tabular
      telescope-nvim
      todo-comments-nvim
      tokyonight-nvim
      trouble-nvim
      vim-better-whitespace
      vim-bookmarks
      # vim-colors-paramount
      vim-commentary
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
      vim-devicons
      vim-dispatch
      vim-dotenv
      vim-fugitive
      vim-gist
      vim-janah
      vim-mustache-handlebars
      vim-nix # ftplugin?
      vim-obsession # keeping track on vim state for open files (cursor pos, open folds etc.)
      vim-prettier
      vim-rails
      vim-slash # set of mappings for enhancing in-buffer search
      vim-surround
      vim-tmux-navigator # seamless ctrl-hjkl navigation with tmux
      webapi-vim # used by vim-gist for api call
    ];
  };
}
