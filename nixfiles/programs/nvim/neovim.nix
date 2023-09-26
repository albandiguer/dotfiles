{
  config,
  pkgs,
  ...
}: {
  # Overlay for nightly builds
  # Nightly nvim build https://github.com/nix-community/neovim-nightly-overlay
  # currently failing  https://github.com/nix-community/neovim-nightly-overlay/issues/164
  # Pin to the latest working commit for now https://github.com/nix-community/neovim-nightly-overlay/pull/177
  nixpkgs.overlays = [
    (
      import (
        let
          # rev = "master";
          rev = "c57746e2b9e3b42c0be9d9fd1d765f245c3827b7";
        in
          builtins.fetchTarball {
            url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
          }
      )
    )
  ];

  home = {
    # TODO convert that to automatically pick all files? order? something like this?
    # home.file."${config.xdg.configHome}/nvim/lua/main.lua".text = builtins.concatStringsSep "\n" (
    #   builtins.map
    #     (n: (builtins.readFile "lua/${n}"))
    #     (builtins.attrNames (builtins.readDir ./lua))
    # );
    file = {
      # Lua files for neovim need to be in :h runtimepath
      # https://github.com/nix-community/home-manager/issues/1834
      # https://hhoeflin.github.io/nix/home_folder_nix/
      # https://teu5us.github.io/nix-lib.html
      "${config.xdg.configHome}/nvim/lua/main.lua".text = builtins.concatStringsSep "\n" [
        (builtins.readFile lua/airline.lua)
        (builtins.readFile lua/settings.lua)
        (builtins.readFile lua/treesitter.lua)
        (builtins.readFile lua/cmp.lua)
        # (builtins.readFile lua/hardtime.lua)
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
        (builtins.readFile lua/neoai.lua)
        (builtins.readFile lua/devdocs.lua)
      ];

      # neovim ftplugins, TODO loop
      "${config.xdg.configHome}/nvim/after/ftplugin/gitcommit.lua".text = builtins.readFile after/ftplugin/gitcommit.lua;
      "${config.xdg.configHome}/nvim/after/ftplugin/lua.lua".text = builtins.readFile after/ftplugin/lua.lua;
      "${config.xdg.configHome}/nvim/after/ftplugin/markdown.lua".text = builtins.readFile after/ftplugin/markdown.lua;
      "${config.xdg.configHome}/nvim/after/ftplugin/ruby.lua".text = builtins.readFile after/ftplugin/ruby.lua;
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

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
      # solargraph
      # ruby-lsp
      buf-language-server # buf

      # NULL-LS (format/diagnostic/code-actions etc) deps
      alejandra # nix code formatter
      statix # nix lints
      # rubocop
      terraform # for terraform_fmt
      nodePackages.prettier
      # nodePackages.eslint
      nodePackages_latest.vscode-langservers-extracted
      nodePackages_latest.yaml-language-server
      nodePackages_latest.bash-language-server
      python310Packages.black # python fmt
      python310Packages.flake8
      vim-vint # for vimscripts
      shfmt # shell script formatter
      # hadolint # docker linter # NOTE currently broken
      # stylua => sumneko does it all now, has a formatter etc
      # elmPackages.elm-format
      # rust-analyzer
      # haskellPackages.brittany
    ];

    plugins = with pkgs.vimPlugins; let
      # can simplify with flake (avoid sha resolution) ?
      # https://www.reddit.com/r/NixOS/comments/mvk5l9/comment/gvqfag9/?utm_source=share&utm_medium=web2x&context=3
      # catppuccin-vim = pkgs.vimUtils.buildVimPlugin {
      #   name = "catppuccin-vim";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "catppuccin";
      #     repo = "nvim";
      #     rev = "22b34eb9f93430bc010dee1523743b62cd2700fc";
      #     sha256 = "1cqc6pws6czdshzxmh89ryf2j1cc2n5maf8v5v6nh8yw02jqghk5";
      #     fetchSubmodules = true;
      #   };
      # };
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

      # vim-medic_chalk = pkgs.vimUtils.buildVimPlugin {
      #   name = "vim-medic_chalk";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "KonnorRogers";
      #     repo = "vim-medic_chalk";
      #     rev = "0f904307708315d418d0d64b4bb1bbd36f2b8044";
      #     sha256 = "eNbdQ1DfSkGkFFAnGv7JjmFzPz0jE1yR3VV9B4aiQ4A=";
      #     fetchSubmodules = false;
      #   };
      # };

      # spaceduck-nvim = pkgs.vimUtils.buildVimPlugin {
      #   name = "spaceduck-nvim";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "pineapplegiant";
      #     repo = "spaceduck";
      #     rev = "350491f19343b24fa85809242089caa02d4dadce";
      #     sha256 = "sha256-lE8y9BA2a4y0B6O3+NyOS7numoltmzhArgwTAner2fE=";
      #     fetchSubmodules = true;
      #   };
      # };

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
      # hardtime-nvim = pkgs.vimUtils.buildVimPlugin {
      #   name = "hardtime-nvim";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "m4xshen";
      #     repo = "hardtime.nvim";
      #     rev = "6826c1fe8bebc63a6886833ca4ffed2fc6ec3382";
      #     sha256 = "sha256-y3Bx16gbYdhfZkS67KIX7V93/y36bnBPglai0vqBvnU=";
      #     fetchSubmodules = false;
      #   };
      # };
      # TODO add theme
    in [
      # feat chatgpt?
      # (plugin " schickling/vim-bufonly ") function to directly fetch plugins from git
      cmp-copilot
      ack-vim
      ayu-vim
      cmp-buffer # nvim-cmp source for buffer words.
      cmp-cmdline # nvim-cmp source for command line
      cmp-conventionalcommits
      cmp-nvim-lsp # nvim-cmp source for neovim's built-in language server client.
      cmp-path
      cmp-git
      delimitMate
      editorconfig-nvim
      jellybeans-vim
      kanagawa-nvim
      lspkind-nvim
      lspcontainers-nvim
      markdown-preview-nvim
      melange-nvim
      neogen
      neoai-nvim
      nui-nvim # required by neoAI https://github.com/Bryley/neoai.nvim
      null-ls-nvim
      nvim-cmp
      nvim-devdocs
      nvim-grb256
      nvim-lspconfig
      nvim-tree-lua
      nvim-treesitter-context
      nvim-treesitter-with-plugins
      nvim-web-devicons
      # hardtime-nvim
      plenary-nvim #dep for nvim-devdocs (async programming with coroutines)
      # spaceduck-nvim
      tabular
      telescope-nvim
      todo-comments-nvim
      trouble-nvim
      # SchemaStore-nvim TODO
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
      webapi-vim # used by vim-gist for api call
      tokyonight-nvim

      cmp_luasnip
      luasnip
      # friendly-snippets
      # vim-vsnip
    ];
  };
}
