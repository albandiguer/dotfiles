{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    # Avoid programs alike vscode copilot unfree licensed to complain
    config.allowUnfree = true;
    # Nightly nvim build https://github.com/nix-community/neovim-nightly-overlay
    # currently failing  https://github.com/nix-community/neovim-nightly-overlay/issues/164
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      }))
    ];
  };

  # For broken packages use the following
  # nixpkgs.config.allowBroken = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # ack
    # awless # https://github.com/wallix/awless
    # commitizen
    # niv # TODO re-enable, currently broken (30/12/22) cycle dependency detected Painless dependencies for Nix projects
    # pomotroid # unsupported aarch64
    # rnix-lsp
    # use lorri init in project directories to setup the shell.nix file
    awscli2
    bash # macos is bash 3xx, need 4+
    bitwarden-cli
    buildpack # cloud native buildpacks, use pack...
    curlie
    cz-cli # conventional commits cli https://github.com/commitizen/cz-cli
    deno
    duf # disk space etc
    github-cli
    google-cloud-sdk # gcloud
    heroku
    htop
    httpie
    iredis # slick redis client
    jq
    jwt-cli
    lato # used by AltaCV
    lorri
    ngrok
    nix-prefetch-git
    nix-prefetch-github # no working at times cant verify sha256 sums
    nodejs
    roboto-slab # used by AltaCV
    silver-searcher # get use to ag instead of ack
    slack
    tldr # when man is tldr
    todoist
    tree
    watch
    wget
    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "FantasqueSansMono"
        "FiraCode"
        "Hack"
        "Hermit"
        "JetBrainsMono"
        "Lilex"
        "ShareTechMono"
        "Terminus"
        "UbuntuMono"
        "VictorMono"
        # "DroidSansMono"
        # "Hasklig"
        # "Iosevka"
        # "Meslo"
        # "Monofur"
        # "Mononoki"
        # "ProggyClean"
        # "SourceCodePro"
      ];
    }) # fonts with devicons
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/trivial-builders.nix#L246
    # writeShellScriptBin "run-commands-on-git-revisions" "echo hellow world"
  ];

  # services.lorri.enable = true; not compat on darwin, do lorri daemon manually

  # enable direnv to autostart nix-shell in directories
  # Create a file called .envrc in your project directory.
  # echo use_nix > .envrc
  # OR use lorri init to start a new config file
  # Then run:
  # direnv allow .
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  # optional for nix flakes support
  # programs.direnv.nix-direnv.enableFlakes = true;

  imports = [
    ./zsh.nix
    ./fzf.nix
    ./git.nix
    nvim/neovim.nix
    ./tmux.nix
    ./vscode.nix
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Symlink classic dotfiles
  home.file.".npmrc".source = config/.npmrc;

  # Marksman, markdown lsp
  # home.file.".bin/marksman" = {
  #   source = builtins.fetchurl {
  #     url = "https://github.com/artempyanykh/marksman/releases/download/2022-10-30/marksman-macos";
  #     sha256 = "0h18izcvy4qiqp8irmz044097s7vq5vaf7xh0xrk757ck7qgs973";
  #   };
  #   executable = true;
  # };

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
