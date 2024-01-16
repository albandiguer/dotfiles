{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      # Avoid programs alike vscode copilot unfree licensed to complain
      allowUnfree = true;

      # For broken packages use the following
      allowBroken = true;
    };
  };

  home = {
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      # ack
      # awless # https://github.com/wallix/awless
      # commitizen
      # niv # TODO re-enable, currently broken (30/12/22) cycle dependency detected Painless dependencies for Nix projects
      # pomotroid # unsupported aarch64
      rnix-lsp
      # use lorri init in project directories to setup the shell.nix file
      awscli2
      act # gh actions locally
      bash # macos is bash 3xx, need 4+
      bat
      bitwarden-cli
      buildpack # cloud native buildpacks, use pack...
      curlie
      cz-cli # conventional commits cli https://github.com/commitizen/cz-cli
      deno
      dive
      duf # disk space etc
      github-cli
      google-cloud-sdk # gcloud
      # graphite-cli, dragging behind, using homebrew
      heroku
      htop
      httpie
      # iredis # slick redis client
      jq
      jwt-cli
      lato # used by AltaCV
      lorri
      marksman
      ngrok # broken atm
      ghc
      nix-prefetch-git
      nix-prefetch-github # no working at times cant verify sha256 sums
      nodejs
      # ruby_3_2 # NOTE global ruby, for rails dev favor rbenv+ruby-build coming with libyaml for psych etc
      # postman
      postgresql # dadbod requires psql
      roboto-slab # used by AltaCV
      silver-searcher # get use to ag instead of ack
      slack
      skhd
      tldr # when man is tldr
      # todoist
      tree
      watch
      wget
      yabai
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

    # Symlink dotfiles
    file = {
      ".npmrc".source = dotfiles/.npmrc;
      ".editorconfig".source = dotfiles/.editorconfig;
      ".inputrc".source = dotfiles/.inputrc;
      ".dive.yml".source = dotfiles/.dive.yml;
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "albandiguer";
    homeDirectory = "/Users/albandiguer";

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
    ./programs/zsh/zsh.nix
    ./programs/fish/fish.nix
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
}
