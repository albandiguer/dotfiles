{
  config,
  pkgs,
  ...
}: {
  # For black (python fixer) we allow broken
  # nixpkgs.config.allowBroken = true;

  # Lua files for neovim need to be in :h runtimepath
  # https://github.com/nix-community/home-manager/issues/1834
  # https://hhoeflin.github.io/nix/home_folder_nix/
  # https://teu5us.github.io/nix-lib.html
  home.file."${config.xdg.configHome}/nvim/lua/main.lua".text = builtins.concatStringsSep "\n" [
    (builtins.readFile lua/airline.lua)
    (builtins.readFile lua/settings.lua)
    (builtins.readFile lua/treesitter.lua)
    (builtins.readFile lua/cmp.lua)
    (builtins.readFile lua/nvim-tree.lua)
    (builtins.readFile lua/telescope.lua)
    (builtins.readFile lua/lspconfig.lua)
    (builtins.readFile lua/null-ls.lua)
    (builtins.readFile lua/trouble.lua)
    (builtins.readFile lua/todo-comments.lua)
    (builtins.readFile lua/snippets.lua)
    (builtins.readFile lua/vim-dispatch.lua)
    (builtins.readFile lua/markdown-preview.lua)
    (builtins.readFile lua/neogen.lua)
  ];
  # TODO convert that to automatically pick all files? order? something like this?
  # home.file."${config.xdg.configHome}/nvim/lua/main.lua".text = builtins.concatStringsSep "\n" (
  #   builtins.map
  #     (n: (builtins.readFile "lua/${n}"))
  #     (builtins.attrNames (builtins.readDir ./lua))
  # );

  # neovim ftplugins, TODO loop
  home.file."${config.xdg.configHome}/nvim/after/ftplugin/lua.lua".text = builtins.readFile after/ftplugin/lua.lua;
  home.file."${config.xdg.configHome}/nvim/after/ftplugin/gitcommit.lua".text = builtins.readFile after/ftplugin/gitcommit.lua;
  home.file."${config.xdg.configHome}/nvim/after/ftplugin/ruby.lua".text = builtins.readFile after/ftplugin/ruby.lua;

  programs.neovim = {
    enable = true;

    # TODO load lua file see youtube video abt that, which?
    extraConfig = builtins.readFile ./init.vim;

    # Enable Python 3 provider.
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.withPython3
    # https://neovim.io/doc/user/provider.html
    withPython3 = true; # default is true so this redundant
    # Plugins for python3 provider:
    extraPython3Packages = ps:
      with ps; [
        # black # not working for null-ls, require it in extraPackages
        # flake8
      ];

    # generatedConfigs thats where we would set things like nvchad

    # withNodeJs = true; no extraNodePackages to do the same as above with python?

    # Extra packages available to nvim
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.extraPackages
    extraPackages = with pkgs; [
      gcc # to compile tree-sitter grammar
      # nixfmt
      # rustfmt
      wget # used by lsp-installer , use :checkhealth in vim
      # texlive.combined.scheme-full

      # Telescope deps
      fd
      ripgrep

      universal-ctags
      # Treesitter
      tree-sitter
      # tree-sitter-grammars.tree-sitter-python

      # LSP deps
      cargo # rnix deps
      sumneko-lua-language-server # lua
      rnix-lsp
      terraform-ls
      sqls
      # solargraph # -> put it in Gemfiles
      # buf-language-server
      solargraph
      buf-language-server # buf

      # NULL-LS (format/diagnostic/code-actions etc) deps
      alejandra # nix code formatter
      statix # nix lints
      # rubocop
      terraform # for terraform_fmt
      nodePackages.prettier
      # nodePackages.eslint
      nodePackages_latest.yaml-language-server
      vim-vint # for vimscripts
      python310Packages.black # python fmt
      python310Packages.flake8
      hadolint # docker linter
      # stylua => sumneko does it all now, has a formatter etc
      # elmPackages.elm-format
      # rust-analyzer
      # haskellPackages.brittany
    ];

    plugins = with pkgs.vimPlugins; let
      # can simplify with flake (avoid sha resolution) ?
      # https://www.reddit.com/r/NixOS/comments/mvk5l9/comment/gvqfag9/?utm_source=share&utm_medium=web2x&context=3
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

      vim-medic_chalk = pkgs.vimUtils.buildVimPlugin {
        name = "vim-medic_chalk";
        src = pkgs.fetchFromGitHub {
          owner = "KonnorRogers";
          repo = "vim-medic_chalk";
          rev = "0f904307708315d418d0d64b4bb1bbd36f2b8044";
          sha256 = "eNbdQ1DfSkGkFFAnGv7JjmFzPz0jE1yR3VV9B4aiQ4A=";
          fetchSubmodules = false;
        };
      };

      spaceduck-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "spaceduck-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "pineapplegiant";
          repo = "spaceduck";
          rev = "350491f19343b24fa85809242089caa02d4dadce";
          sha256 = "sha256-lE8y9BA2a4y0B6O3+NyOS7numoltmzhArgwTAner2fE=";
          fetchSubmodules = true;
        };
      };

      shiretolin-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "shiretolin-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "yasukotelin";
          repo = "shirotelin";
          rev = "c486f6f1c88acb585859b8d96dd68eafeb14bbd3";
          sha256 = "sha256-LkMJNIjkpOV4kBnn4XOzipA9DMtaYYwLpL5zcYK2LgE=";
          fetchSubmodules = true;
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

      nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
      # nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (
      #   plugins:
      #     with pkgs.tree-sitter-grammars; [
      #       tree-sitter-c
      #       # tree-sitter-cmake
      #       tree-sitter-dockerfile
      #       tree-sitter-elm
      #       tree-sitter-graphql
      #       tree-sitter-haskell
      #       tree-sitter-hcl
      #       tree-sitter-html
      #       tree-sitter-javascript
      #       tree-sitter-json
      #       tree-sitter-json5
      #       tree-sitter-lua
      #       tree-sitter-markdown
      #       tree-sitter-nix
      #       # tree-sitter-python
      #       # tree-sitter-ruby
      #       # tree-sitter-tsx
      #       # tree-sitter-typescript
      #       # tree-sitter-mermaid
      #       tree-sitter-vim
      #       tree-sitter-yaml
      #     ]
      # );
    in [
      # (plugin " schickling/vim-bufonly ") function to directly fetch plugins from git
      cmp-copilot
      # nerdtree
      ack-vim
      ayu-vim
      cmp-buffer # nvim-cmp source for buffer words.
      cmp-cmdline # nvim-cmp source for command line
      cmp-conventionalcommits
      cmp-nvim-lsp # nvim-cmp source for neovim's built-in language server client.
      cmp-path
      cmp-vsnip
      delimitMate
      editorconfig-nvim
      friendly-snippets
      jellybeans-vim
      kanagawa-nvim
      lspcontainers-nvim
      markdown-preview-nvim
      melange-nvim
      neogen
      null-ls-nvim
      nvim-cmp
      nvim-grb256
      nvim-lspconfig
      nvim-tree-lua
      nvim-treesitter-context
      nvim-treesitter-with-plugins
      nvim-web-devicons
      spaceduck-nvim
      tabular
      telescope-nvim
      todo-comments-nvim
      trouble-nvim
      vim-airline
      vim-better-whitespace
      vim-bookmarks
      vim-colors-paramount
      vim-commentary
      vim-devicons
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
      vim-dispatch
      vim-fugitive
      vim-gist
      vim-janah
      # vim-jsdoc # ftplugin? NOTE: redundant with neogen?
      vim-mustache-handlebars
      vim-nix # ftplugin?
      vim-obsession # keeping track on vim state for open files (cursor pos, open folds etc.)
      vim-prettier
      vim-slash # set of mappings for enhancing in-buffer search
      vim-surround
      vim-tmux-navigator # seamless ctrl-hjkl navigation with tmux
      vim-vsnip
      webapi-vim # used by vim-gist for api call
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
