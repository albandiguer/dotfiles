{ pkgs, lib, ... }:
{
  home = {
    sessionVariables = {
      GIT_SPICE_NO_GS_WARNING = "1";
    };

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      # Development Tools
      act # gh actions locally
      buildpack # cloud native buildpacks, use pack..., checkout nixpacks
      dive # docker image inspection
      ngrok
      overmind
      awslogs # aws cloudwatch logs CLI
      rtk # token-savvy llm output (claude-code + opencode)
      butane # fedora coreOS ignition configs

      # Git Tools
      diffnav # git diff pager with file tree (used by gh-dash)
      cz-cli # conventional commits cli https://github.com/commitizen/cz-cli
      nix-prefetch-git
      nix-prefetch-github # not working at times cant verify sha256 sums
      worktrunk # [manage git worktree](https://github.com/max-sixty/worktrunk)
      git-spice
      tuicr # code reviews

      # Shell & CLI Utilities
      bash # macos is bash 3xx, need 4+
      bat # better cat
      curlie # curl with easy syntax
      duf # disk space etc
      jq # json processing
      jwt-cli # jwt decoder
      tldr # when man is tldr
      tree # directory structure viewer
      watch # execute command periodically
      wget # file downloader
      qrencode # generate a qr code
      sshed # ssh config management
      bitwarden-cli
      bitwarden-desktop # GUI app, linked into user profile
      sox # audio sampler, whisper deps

      # Fonts
      lato # used by AltaCV
      roboto-slab # used by AltaCV
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
    ];

    file = {
      ".default-gems".source = ../../dotfiles/.default-gems; # TODO: move in mise.nix ?
      ".default-node-packages".source = ../../dotfiles/.default-node-packages;
      ".default-python-packages".source = ../../dotfiles/.default-python-packages;
      ".dive.yml".source = ../../dotfiles/.dive.yml;
      ".editorconfig".source = ../../dotfiles/.editorconfig;
      ".inputrc".source = ../../dotfiles/.inputrc;
      ".npmrc".source = ../../dotfiles/.npmrc;
      # ".ghstackrc".source = ../../dotfiles/.ghstackrc;
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # username = "albandiguer";
    # homeDirectory = "/Users/albandiguer";

    sessionPath = [
      "./bin"
      "/opt/homebrew/bin"
      "\${HOME}/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      DEFAULT_AI_AGENT = lib.mkDefault "pi";
      ANTHROPIC_BASE_URL = "http://headroom.lab/";
      OPENAI_BASE_URL = "http://headroom.lab/";
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
    ../../programs/eza.nix
    ../../programs/fish
    ../../programs/atuin.nix
    ../../programs/btop.nix
    ../../programs/fzf.nix
    ../../programs/carapace.nix
    ../../programs/git.nix
    ../../programs/gh.nix
    ../../programs/neovim
    ../../programs/starship.nix
    ../../programs/tmux
    ../../programs/direnv.nix
    ../../programs/home-manager.nix
    ../../programs/mise.nix
    ../../programs/wezterm
    ../../programs/lazygit.nix
    ../../programs/opencode.nix
    ../../programs/pi.nix
    ../../programs/try.nix
    ../../programs/sesh
    ../../programs/zoxide.nix
    ../../programs/worktrunk.nix
    ../../programs/herdr.nix
  ];
}
