{pkgs, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    eza # https://github.com/eza-community/eza
    graphite-cli
    marp-cli #https://github.com/marp-team/marp-cli
    openssl
    bruno
    awslogs
  ];

  services = {
    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;
    lorri.enable = true;
    sketchybar = {
      enable = false;
      config = builtins.readFile ../home/dotfiles/sketchybarrc;
    };
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

  homebrew = {
    enable = true;
    brews = [
      "git-crypt"
      "gpg"
      "iredis"
      "libpq"
      "libyaml"
      "postgresql@15" # cant remember why, for dadbod?
      "puma/puma/puma-dev"
      "sapling"
      "vips" # Image processing library
      # "hashicorp/tap/terraform"
      # "python-setuptools" # awsume deps
    ];
    casks = [
      # "dash"
      "licecap"
      "monitorcontrol"
      "notion"
      "obsidian"
      "raycast"
      "httpie"
      "chatbox"
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
