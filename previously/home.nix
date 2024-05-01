{
  pkgs,
  config,
  ...
}: {
  home = {
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      # ack
      awscli2
      act # gh actions locally
      bash # macos is bash 3xx, need 4+
      bat
      bitwarden-cli
      buildpack # cloud native buildpacks, use pack...
      commitlint
      curlie
      cz-cli # conventional commits cli https://github.com/commitizen/cz-cli
      deno
      dive
      duf # disk space etc
      github-cli
      google-cloud-sdk # gcloud, gsutils
      heroku
      htop
      httpie
      jq
      jwt-cli
      lato # used by AltaCV
      marksman # markdown lsp https://github.com/artempyanykh/marksman
      ngrok # broken atm
      ghc
      nix-prefetch-git
      nix-prefetch-github # no working at times cant verify sha256 sums
      nodejs
      # ruby_3_2 # NOTE global ruby, for rails dev favor rbenv+ruby-build coming with libyaml for psych etc
      # oh-my-fish
      # postman
      postgresql # dadbod requires psql
      roboto-slab # used by AltaCV
      silver-searcher # get use to ag instead of ack
      slack
      tldr # when man is tldr
      # todoist
      tree
      watch
      wget
      rubyPackages.erb-formatter
      rubyPackages.htmlbeautifier
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
      ".npmrc".source = dotfiles/.npmrc;
      ".editorconfig".source = dotfiles/.editorconfig;
      ".inputrc".source = dotfiles/.inputrc;
      ".dive.yml".source = dotfiles/.dive.yml;
      # "Google Drive".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/CloudStorage/GoogleDrive-alban.diguer@gmail.com/My Drive";
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
    # ./programs/zsh/zsh.nix
    ./programs/fish/fish.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/nvim/neovim.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    ./programs/vscode.nix
    ./programs/direnv.nix
    ./programs/home-manager.nix
  ];
}
