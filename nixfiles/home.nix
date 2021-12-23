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

  imports = [ config/zsh.nix config/git.nix config/neovim.nix ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # set your user tokens as enivornment variables, such as ~/.secrets
  # See the README for examples.

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
