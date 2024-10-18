{pkgs, ...}: {
  home = {
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      # bitwarden-cli # not working
      act # gh actions locally
      awscli2
      # aws-sso-cli not necessary
      ssm-session-manager-plugin # https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
      bash # macos is bash 3xx, need 4+
      bat
      buildpack # cloud native buildpacks, use pack...
      curlie
      cz-cli # conventional commits cli https://github.com/commitizen/cz-cli
      # deno
      dive
      duf # disk space etc
      # ghc
      google-cloud-sdk # gcloud, gsutils
      heroku
      htop
      httpie
      jq
      jwt-cli
      lato # used by AltaCV
      mise # pkg manager for programming langs https://github.com/jdx/mise
      marksman # markdown lsp https://github.com/artempyanykh/marksman
      ngrok # broken atm
      nix-prefetch-git
      nix-prefetch-github # no working at times cant verify sha256 sums
      postgresql # dadbod requires psql
      roboto-slab # used by AltaCV
      silver-searcher # get use to ag instead of ack
      slack
      tldr # when man is tldr
      tree
      watch
      wget
      python311Packages.ipykernel
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
          "Iosevka"
        ];
      }) # fonts with devicons
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/trivial-builders.nix#L246
      # writeShellScriptBin "run-commands-on-git-revisions" "echo hellow world"
    ];

    # copy dotfiles
    file = {
      ".npmrc".source = ../../dotfiles/.npmrc;
      ".editorconfig".source = ../../dotfiles/.editorconfig;
      ".inputrc".source = ../../dotfiles/.inputrc;
      ".dive.yml".source = ../../dotfiles/.dive.yml;
      # "Google Drive".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/CloudStorage/GoogleDrive-alban.diguer@gmail.com/My Drive";
      ".default-gems".source = ../../dotfiles/.default-gems; # TODO: move in mise.nix
      ".default-python-packages".source = ../../dotfiles/.default-python-packages;
      ".ghstackrc".source = ../../dotfiles/.ghstackrc;
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # username = "albandiguer";
    # homeDirectory = "/Users/albandiguer";

    sessionPath = ["./bin" "/opt/homebrew/bin"];
    sessionVariables = {
      EDITOR = "nvim";
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  imports = [
    # ../../zsh
    ../../programs/fish
    ../../programs/fzf.nix
    ../../programs/git.nix
    ../../programs/gh.nix
    ../../programs/neovim
    ../../programs/starship.nix
    ../../programs/tmux.nix
    ../../programs/vscode.nix
    ../../programs/direnv.nix
    ../../programs/home-manager.nix
    ../../programs/mise.nix
    ../../programs/wezterm.nix
    ../../programs/alacritty.nix
  ];
}
