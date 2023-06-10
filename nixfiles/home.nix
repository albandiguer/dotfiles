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
    # overlays = [
    #   (import (builtins.fetchTarball {
    #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    #   }))
    # ];
    # Pin to the latest working commit for now https://github.com/nix-community/neovim-nightly-overlay/pull/177
    overlays = [
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
    # iredis # slick redis client
    jq
    jwt-cli
    lato # used by AltaCV
    lorri
    marksman
    # ngrok broken atm
    nix-prefetch-git
    nix-prefetch-github # no working at times cant verify sha256 sums
    nodejs
    ruby_3_1
    postman
    roboto-slab # used by AltaCV
    silver-searcher # get use to ag instead of ack
    slack
    skhd
    tldr # when man is tldr
    todoist
    tree
    watch
    wget
    yabai
    (nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
        "Hermit"
        "JetBrainsMono"
        "Lilex"
        "ShareTechMono"
        "Terminus"
        "UbuntuMono"
        "VictorMono"
      ];
    }) # fonts with devicons
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/trivial-builders.nix#L246
    # writeShellScriptBin "run-commands-on-git-revisions" "echo hellow world"
  ];

  # WARN not compat on darwin, do lorri daemon manually
  # services.lorri.enable = true;

  imports = [
    ./programs/zsh/zsh.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/nvim/neovim.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/vscode.nix
    ./programs/direnv.nix
    ./programs/home-manager.nix
    ./programs/yabai.nix
    ./programs/skhd.nix
  ];

  # Symlink classic dotfiles
  home.file.".npmrc".source = dotfiles/.npmrc;
  home.file.".editorconfig".source = dotfiles/.editorconfig;
  home.file.".inputrc".source = dotfiles/.inputrc;

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
  home.stateVersion = "22.11";
}
