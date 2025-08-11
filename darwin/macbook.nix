{lib, pkgs, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # -- Cloud & DevOps --
    awslogs
    podman
    podman-compose
    localstack # aws mock 
		bitwarden-desktop

    # -- Development Tools --
		# bruno # broken in 07/2025 
    graphite-cli # Git Client
    lazydocker  # Docker TUI
    openssl
    icu         # mise postgres deps
    gitmux  # git tmux integration

    # -- Cloud & Infra --
    ssm-session-manager-plugin # aws ecs execute-command  https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
		cloudflared

    # -- CLI Utilities --
    eza         # https://github.com/eza-community/eza
    portaudio   # for aider voice - https://aider.chat/docs/install/optional.html#enable-voice-coding
    _1password-cli # 1Password CLI tool

    # -- Presentation & Communication --
    marp-cli    # Markdown to Presentation tool
    slack

    # -- AI related --
		# ollama
    claude-code
		whisper-cpp # https://github.com/raycast/extensions/tree/603ada168a81f9acc062dc2ad524f157602423a7/extensions/whisper-dictation/#-whisper-dictation-for-raycast
  ];

  # default nixbld (nix build) group 
  ids.gids.nixbld = lib.mkDefault 30000;
  users.groups.nixbld.gid = lib.mkDefault 30000;

  services = {
    lorri.enable = false; # too painful, use mise
    sketchybar = {
      enable = false;
      config = builtins.readFile ../home/dotfiles/sketchybarrc;
    };
    # ollama = { # NOTE: not yet available https://github.com/nix-darwin/nix-darwin/pull/972
    #   enable = true;
    #   loadModels = [ "llama3" "nomic-embed-text" ];
    # };
  };

  nix.package = pkgs.nix; # TODO figure what is it

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh.enable = true; # default shell on catalina
    # direnv.enable = true; # in home-manager
  };
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };  
  # https://github.com/LnL7/nix-darwin/blob/master/tests/system-defaults-write.nix
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  
  # Disable system sounds
  system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
  system.defaults.NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;

  # NOTE: brews will be available accross all user sessions on the machine,
  # for example tectonic is needed by Audrey
  homebrew = {
    enable = true;
    brews = [
      "bitwarden-cli"
      "git-crypt"
      "gpg"
      "iredis"
      "libpq"
      "libyaml"
      "puma/puma/puma-dev"
      # "sapling"
      "tectonic" # latex https://tectonic-typesetting.github.io/book/latest/introduction/index.html 
      "vips" # Image processing library
      # "hashicorp/tap/terraform"
      # "python-setuptools" # awsume deps
    ];
    casks = [
      # "dash"
      "1password" # 1Password GUI application
			"bruno"
      "chatbox"
      "freetube"
      # "httpie"
      "licecap"
      "monitorcontrol"
      "notion"
      "obsidian"
      "raycast"
    ];
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    # Avoid programs alike vscode copilot unfree licensed to complain
    allowUnfree = true;
    # For broken packages use the following
    allowBroken = true;
  };
}
