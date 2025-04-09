{pkgs, ...}: {
  home = {
    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      # Development Tools
      act # gh actions locally
      buildpack # cloud native buildpacks, use pack..., checkout nixpacks
      dive # docker image inspection
      ngrok # broken atm

      # Git Tools
      cz-cli # conventional commits cli https://github.com/commitizen/cz-cli
      nix-prefetch-git
      nix-prefetch-github # not working at times cant verify sha256 sums

      # Shell & CLI Utilities
      bash # macos is bash 3xx, need 4+
      bat # better cat
      curlie # curl with easy syntax
      duf # disk space etc
      httpie # http client
      jq # json processing
      jwt-cli # jwt decoder
      silver-searcher # get use to ag instead of ack
      tldr # when man is tldr
      tree # directory structure viewer
      watch # execute command periodically
      wget # file downloader

      # Security & Credentials
      # bitwarden-cli # not working

      # Fonts
      lato # used by AltaCV
      roboto-slab # used by AltaCV

      # Nerd Fonts
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

      # Disabled/Legacy
      # ghc
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/trivial-builders.nix#L246
      # writeShellScriptBin "run-commands-on-git-revisions" "echo hellow world"
    ];

    # copy dotfiles
    file = {
      ".default-gems".source = ../../dotfiles/.default-gems; # TODO: move in mise.nix ?
      ".default-node-packages".source = ../../dotfiles/.default-node-packages;
      ".default-python-packages".source = ../../dotfiles/.default-python-packages;
      ".dive.yml".source = ../../dotfiles/.dive.yml;
      ".editorconfig".source = ../../dotfiles/.editorconfig;
      ".gitmux.conf".source = ../../dotfiles/.gitmux.yaml;
      ".inputrc".source = ../../dotfiles/.inputrc;
      ".npmrc".source = ../../dotfiles/.npmrc;
      # ".ghstackrc".source = ../../dotfiles/.ghstackrc;
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # username = "albandiguer";
    # homeDirectory = "/Users/albandiguer";

    sessionPath = ["./bin" "/opt/homebrew/bin"];
    sessionVariables = {
      EDITOR = "nvim";

      # Open .env.aider file for defaults and dets on each var
      AIDER_ATTRIBUTE_AUTHOR="false";
      AIDER_ATTRIBUTE_COMMITTER="false";
      AIDER_AUTO_COMMITS="false";
      AIDER_EDITOR = "nvim";
      AIDER_SUBTREE_ONLY="true";
      # Aider Everforest-ish theme
      AIDER_USER_INPUT_COLOR = "#A7C080";
      AIDER_TOOL_OUTPUT_COLOR = "#7FBBB3";
      AIDER_TOOL_ERROR_COLOR = "#E67E80";
      AIDER_TOOL_WARNING_COLOR = "#DBBC7F";
      AIDER_ASSISTANT_OUTPUT_COLOR = "#83B6AF";
      AIDER_COMPLETION_MENU_COLOR = "#D3C6AA";
      AIDER_COMPLETION_MENU_BG_COLOR = "#2D353B";
      AIDER_COMPLETION_MENU_CURRENT_COLOR = "#D3C6AA";
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
    ../../programs/btop.nix
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
