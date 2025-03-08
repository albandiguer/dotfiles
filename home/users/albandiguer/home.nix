{pkgs, ...}: {
  home = {
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      bitwarden-cli # not working
      act # gh actions locally
      # awscli2 # in mise
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
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.hack
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.lilex
      # nerd-fonts.meslo
      # nerd-fonts.share-tech-mono
      # nerd-fonts.terminus
      nerd-fonts.ubuntu-mono
      nerd-fonts.victor-mono
      nerd-fonts.zed-mono
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/trivial-builders.nix#L246
      # writeShellScriptBin "run-commands-on-git-revisions" "echo hellow world"
    ];

    # copy dotfiles
    file = {
      ".npmrc".source = ../../dotfiles/.npmrc;
      ".editorconfig".source = ../../dotfiles/.editorconfig;
      ".inputrc".source = ../../dotfiles/.inputrc;
      ".dive.yml".source = ../../dotfiles/.dive.yml;
      ".default-gems".source = ../../dotfiles/.default-gems; # TODO: move in mise.nix
      ".default-python-packages".source = ../../dotfiles/.default-python-packages;
      ".default-node-packages".source = ../../dotfiles/.default-node-packages;
      # ".ghstackrc".source = ../../dotfiles/.ghstackrc;
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # username = "albandiguer";
    # homeDirectory = "/Users/albandiguer";

    sessionPath = ["./bin" "/opt/homebrew/bin"];
    sessionVariables = {
      EDITOR = "nvim";

      # Aider Everforest-ish theme
      # Set the color for user input (soft sage green)
      AIDER_USER_INPUT_COLOR = "#A7C080";
      # Set the color for tool output (muted blue)
      AIDER_TOOL_OUTPUT_COLOR = "#7FBBB3";
      # Set the color for tool error messages (soft red)
      AIDER_TOOL_ERROR_COLOR = "#E67E80";
      # Set the color for tool warning messages (warm yellow)
      AIDER_TOOL_WARNING_COLOR = "#DBBC7F";
      # Set the color for assistant output (calm blue)
      AIDER_ASSISTANT_OUTPUT_COLOR = "#83B6AF";
      # Set the color for the completion menu (light sage)
      AIDER_COMPLETION_MENU_COLOR = "#D3C6AA";
      # Set the background color for the completion menu (dark background)
      AIDER_COMPLETION_MENU_BG_COLOR = "#2D353B";
      # Set the color for the current item in the completion menu (light text)
      AIDER_COMPLETION_MENU_CURRENT_COLOR = "#D3C6AA";
      # Set the background color for the current item in the completion menu (highlighted background)
      AIDER_COMPLETION_MENU_CURRENT_BG_COLOR = "#475258";
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
    ../../programs/carapace.nix
    ../../programs/git.nix
    ../../programs/gh.nix
    ../../programs/neovim
    ../../programs/starship.nix
    ../../programs/tmux.nix
    ../../programs/kitty.nix
    ../../programs/vscode.nix
    ../../programs/direnv.nix
    ../../programs/home-manager.nix
    ../../programs/mise.nix
    ../../programs/wezterm.nix
    ../../programs/alacritty.nix
    ../../programs/lazygit.nix
  ];
}
