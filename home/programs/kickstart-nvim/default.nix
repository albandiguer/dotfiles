{pkgs, ...}: let

  treesitterWithPlugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    plugins: with plugins; [ 
      tree-sitter-latex 
    ]
  );

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithPlugins.dependencies;
  };

in {
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    rust-analyzer-unwrapped
    black
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;
    withRuby = false; # using mise, type `:!which ruby` to confirm

    plugins =  [
      treesitterWithPlugins
    ];

    # Require that albandiguer/init.lua file linked dynamically below
    extraConfig = ''
      lua require('albandiguer')
    '';
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  home.file."./.config/nvim/lua/albandiguer/init.lua".text = ''
    -- Add treesitter plugin path
    vim.opt.runtimepath:append("${treesitterWithPlugins}")
    -- Add treesitter parsers path
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithPlugins;
  };
}
