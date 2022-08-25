{
  config,
  pkgs,
  ...
}: {
  # For black (python fixer) we allow broken
  nixpkgs.config.allowBroken = true;

  programs.neovim = {
    enable = true;

    # TODO load lua file see youtube video abt that
    extraConfig = builtins.readFile ./config.vim;

    # Enable Python 3 provider.
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.withPython3
    withPython3 = true; # default is true so this redundant
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
      cargo # deps for rnix lsp
      # deno
      gcc # to compile tree-sitter grammars...
      # nixfmt
      # rustfmt
      wget # used by lsp-installer , use :checkhealth in vim
      # texlive.combined.scheme-full

      universal-ctags
      # used to compile tree-sitter grammar
      tree-sitter
      # tree-sitter-grammars.tree-sitter-python

      # installs different language servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      # nodePackages.lehre
      # nodePackages.typescript
      # nodePackages.typescript-language-server

      # null-ls deps
      alejandra
      statix
      rubocop
      terraform # for terraform_fmt
      nodePackages.prettier
      # nodePackages.eslint  => install locally in projects
      vim-vint
      black # python fmt
      python39Packages.flake8
      stylua

      # elmPackages.elm-format
      # rust-analyzer
      # haskellPackages.brittany
    ];

    plugins = with pkgs.vimPlugins; let
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

      #     "rev": "3115044059b3adcd12ea525994de6a255a8bf783",
      #     "sha256": "G5XG/4IuKZhbPR0JMpUjmctP5WPK7YwdR+WytNYcI2k=",
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

      nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins:
          with pkgs.tree-sitter-grammars; [
            tree-sitter-c
            tree-sitter-cmake
            tree-sitter-elm
            tree-sitter-graphql
            tree-sitter-haskell
            tree-sitter-hcl
            tree-sitter-html
            tree-sitter-javascript
            tree-sitter-lua
            tree-sitter-nix
            tree-sitter-python
            tree-sitter-ruby
            tree-sitter-vim
            tree-sitter-yaml
          ]
      );
    in [
      ack-vim
      ayu-vim
      catppuccin-vim
      cmp-buffer
      cmp-cmdline
      # cmp-copilot
      cmp-nvim-lsp
      cmp-path
      cmp-vsnip
      delimitMate
      editorconfig-vim
      fzf-vim # Replace with Telescope
      nvim-lspconfig
      nvim-grb256
      nerdtree
      null-ls-nvim
      nvim-cmp
      nvim-treesitter-with-plugins
      nvim-treesitter-context
      nvim-web-devicons
      tabular
      trouble-nvim
      vim-airline
      vim-better-whitespace
      vim-bookmarks
      vim-commentary
      vim-devicons
      vim-dispatch
      vim-fugitive
      vim-gist
      vim-jsdoc
      vim-nix # so it is not lost with nix file, commenting etc
      vim-obsession
      vim-prettier
      vim-slash
      vim-tmux-navigator # seamless ctrl-hjkl navigation with tmux
      vim-vsnip
      webapi-vim # used by vim-gist for api call
      # or you can use our function to directly fetch plugins from git
      # (plugin "schickling/vim-bufonly")
    ]; # Only loaded if programs.neovim.extraConfig is set
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
