{pkgs, ...}: let

  treesitterWithAllGrammars = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;

  treesitterParsers = pkgs.symlinkJoin {
    name = "treesitterParsers";
    paths = treesitterWithAllGrammars.dependencies;
  };

in {
  # TODO nothing to do here? put in home.nix or extraPackages
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
      treesitterWithAllGrammars
    ];

    # xtra packages available to neovim
    extraPackages = with pkgs; [
      # deno # for peek.nvim
      cargo
      nodePackages_latest.prettier # --> mason?
      # yamlfmt --> in mason
      yarn # mdpreview
    ];

  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  # Add treesitter-nix-paths.lua file so we can require it from lazy config function evaluated at runtimne
  # Lazy cleans neovim runtimepath on start (see :set runtimepath?) so we re-add these after
  home.file."./.config/nvim/lua/albandiguer/treesitter-nix-paths.lua".text = ''
    -- Add treesitter plugin path
    vim.opt.runtimepath:prepend("${treesitterWithAllGrammars}")
    -- Add treesitter parsers path
    vim.opt.runtimepath:prepend("${treesitterParsers}")
  '';
  # TODO: here we need to require that file somwwhere

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  # > ~/.local/share/nvim is where Neovim stores user-specific data that supports the operation, customization, and extension of the editor. It helps in managing plugins, storing runtime files, and keeping persistent data, all of which are crucial for a smooth and personalized Neovim experience.
  # NOTE: so this is used in 
  # parser_install_dir = vim.fn.stdpath 'data' .. '/nix/nvim-treesitter',
  # verify it works fine
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithAllGrammars;
  };
}
