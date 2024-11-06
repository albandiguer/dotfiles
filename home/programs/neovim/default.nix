{pkgs, ...}: let

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

    plugins =  [];

    # xtra packages available to neovim
    extraPackages = with pkgs; [
      # deno # for peek.nvim
      cargo
      # nodePackages_latest.prettier # --> mason?
      # yamlfmt --> in mason
      yarn # mdpreview
    ];

  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}
