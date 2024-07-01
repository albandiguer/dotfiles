{
  config,
  pkgs,
  ...
}: {
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
        (builtins.readFile lua/lualine.lua)
        (builtins.readFile lua/settings.lua)
        (builtins.readFile lua/treesitter.lua)
        (builtins.readFile lua/cmp.lua)
        (builtins.readFile lua/nvim-tree.lua)
        (builtins.readFile lua/nvim-notify.lua)
        (builtins.readFile lua/telescope.lua)
        (builtins.readFile lua/lspconfig.lua)
        (builtins.readFile lua/null-ls.lua)
        (builtins.readFile lua/trouble.lua)
        (builtins.readFile lua/todo-comments.lua)
        (builtins.readFile lua/snippets.lua)
        (builtins.readFile lua/vim-dispatch.lua)
        (builtins.readFile lua/markdown-preview.lua)
        (builtins.readFile lua/neogen.lua)
        # (builtins.readFile lua/obsidian.lua)
        (builtins.readFile lua/neoai.lua)
        (builtins.readFile lua/devdocs.lua)
      ];

      # neovim ftplugins, TODO loop
      "${config.xdg.configHome}/nvim/after/ftplugin/gitcommit.lua".text = builtins.readFile after/ftplugin/gitcommit.lua;
      "${config.xdg.configHome}/nvim/after/ftplugin/lua.lua".text = builtins.readFile after/ftplugin/lua.lua;
      "${config.xdg.configHome}/nvim/after/ftplugin/markdown.lua".text = builtins.readFile after/ftplugin/markdown.lua;
      "${config.xdg.configHome}/nvim/after/ftplugin/ruby.lua".text = builtins.readFile after/ftplugin/ruby.lua;
      "${config.xdg.configHome}/nvim/after/ftplugin/terraform.lua".text = builtins.readFile after/ftplugin/terraform.lua;
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
    # extraPython3Packages = ps:
    # with ps; [
    # black # not working for null-ls, require it in extraPackages
    # flake8
    # ];

    # generatedConfigs thats where we would set things like nvchad

    # withNodeJs = true; no extraNodePackages to do the same as above with python?

    # Extra packages available to nvim
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.neovim.extraPackages
    extraPackages = with pkgs; [
      gcc # to compile tree-sitter grammar
      # nixfmt
      # rustfmt
      commitlint
      wget # used by lsp-installer , use :checkhealth in vim
      # texlive.combined.scheme-full
      redis # dadbod deps
      postgresql # dadbod deps
      fd # Telescope deps
      universal-ctags
      # Treesitter
      tree-sitter
      # tree-sitter-grammars.tree-sitter-python
      # LSP deps
      sumneko-lua-language-server # lua
      terraform-ls
      sqls
      # solargraph
      # ruby-lsp
      nil # nix lang server
      buf-language-server # buf
      # docker-compose-language-service
      # NULL-LS (format/diagnostic/code-actions etc) deps
      alejandra # nix code formatter
      statix # nix lints
      pgformatter # https://github.com/darold/pgFormatter
      pyright
      ripgrep # used by obsidian nvim
      # rubocop
      terraform # for terraform_fmt
      nodePackages.prettier
      nodePackages_latest.eslint
      nodePackages_latest.vscode-langservers-extracted #html css json eslint
      nodePackages_latest.yaml-language-server
      nodePackages_latest.bash-language-server
      nodePackages_latest.typescript-language-server
      # bash-language-server
      nodePackages_latest.dockerfile-language-server-nodejs
      # nodePackages_latest.sql-language-server
      python312Packages.black # python fmt
      python312Packages.flake8
      vim-vint # for vimscripts
      shfmt # shell script formatter
      hadolint # docker linter # NOTE currently broken
      tailwindcss-language-server # tailwind lsp
      # stylua => sumneko does it all now, has a formatter etc
      # elmPackages.elm-format
      # rust-analyzer
      # haskellPackages.brittany
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
