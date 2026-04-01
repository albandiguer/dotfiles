{ lib, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # -- Cloud & DevOps/Infra --
    awslogs
    bitwarden-desktop
    cloudflared
    k3d
    # localstack # aws mock
    podman
    podman-compose
    podman-tui
    podlet # docker/compose -> quadlet
    ssm-session-manager-plugin # aws ecs execute-command  https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
    butane

    # -- Development Tools --
    # bruno # broken in 07/2025
    git-crypt
    graphite-cli # Git Client
    lazydocker # Docker TUI
    openssl
    icu # mise postgres deps
    gitmux # git tmux integration

    # -- CLI Utilities --

    _1password-cli # 1Password CLI tool
    sox # audio sampler, whisper deps
    sshed # ssh config management

    # -- Presentation & Communication --
    marp-cli # Markdown to Presentation tool
    slack

    # -- AI related --
    # ollama
    claude-code
    whisper-cpp # https://github.com/raycast/extensions/tree/603ada168a81f9acc062dc2ad524f157602423a7/extensions/whisper-dictation/#-whisper-dictation-for-raycast
    # opencode  # Now managed via home-manager
    rtk # https://www.rtk-ai.app/#install - token savvy bash output for llm ingestion
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
  nix.settings = {
    experimental-features = "nix-command flakes";
    # auto-optimise-store = true; # Optimize during builds
  };

  # Automatic Nix store optimization
  nix.optimise.automatic = true;

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 7;
    }; # Run weekly on Sundays
    options = "--delete-older-than 30d"; # Keep last 30 days
  };

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

  # Disable Spotlight hotkeys (Cmd+Space and Cmd+Alt+Space) in favor of Raycast
  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # Disable 'Cmd + Space' for Spotlight Search
        "64" = {
          enabled = false;
        };
        # Disable 'Cmd + Alt + Space' for Finder search window
        "65" = {
          enabled = false;
        };
        # Disable 'Ctrl + Space' for Select previous input source
        "60" = {
          enabled = false;
        };
        # Disable 'Ctrl + Alt + Space' for Select next input source
        "61" = {
          enabled = false;
        };
      };
    };
  };

  # NOTE: brews will be available accross all user sessions on the machine,
  # for example tectonic is needed by Audrey
  homebrew = {
    enable = true;
    brews = [
      "bitwarden-cli"
      "claude-squad"
      "gpg"
      "iredis"
      "libpq"
      "libyaml"
      "nixfmt"
      "puma/puma/puma-dev"
      "tectonic" # latex https://tectonic-typesetting.github.io/book/latest/introduction/index.html
      "vips" # Image processing library
      # "hashicorp/tap/terraform"
      # "python-setuptools" # awsume deps
      # "sapling"
    ];
    casks = [
      "1password" # 1Password GUI application
      "auto-claude"
      "bruno"
      "chatbox"
      "claude"
      "claude-island"
      "font-sf-mono-nerd-font-ligaturized"
      "freetube"
      "licecap"
      "monitorcontrol"
      "notion"
      "obsidian"
      "raycast"
      "conductor"
      # "dash"
      # "httpie"
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
