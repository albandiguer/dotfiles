{ lib, pkgs, ... }:
{
  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = with pkgs; [
      # -- Cloud & DevOps/Infra --
      cloudflared
      lima # linux machine (microvms)
    ];

    shells = [ "/run/current-system/sw/bin/fish" ];
  };

  # default nixbld (nix build) group
  ids.gids.nixbld = lib.mkDefault 30000;

  users = {
    groups.nixbld.gid = lib.mkDefault 30000;
    users.albandiguer.shell = "/run/current-system/sw/bin/fish";
  };

  services = {
    # ollama = { # NOTE: not yet available https://github.com/nix-darwin/nix-darwin/pull/972
    #   enable = true;
    #   loadModels = [ "llama3" "nomic-embed-text" ];
    # };
  };

  nix = {
    # Necessary for using flakes on this system.
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "albandiguer"
      ];
      # auto-optimise-store = true; # Optimize during builds
    };

    # Automatic Nix store optimization
    optimise.automatic = true;

    # Automatic garbage collection
    gc = {
      automatic = true;
      interval = {
        Weekday = 7;
      }; # Run weekly on Sundays
      options = "--delete-older-than 30d"; # Keep last 30 days
    };
  };

  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh.enable = true; # default shell on catalina
    fish.enable = true;
  };

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    # https://github.com/LnL7/nix-darwin/blob/master/tests/system-defaults-write.nix
    defaults.NSGlobalDomain.InitialKeyRepeat = 15;
    defaults.NSGlobalDomain.KeyRepeat = 2;

    # Disable system sounds
    defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 0;
    defaults.NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;

    # Disable Spotlight hotkeys (Cmd+Space and Cmd+Alt+Space) in favor of Raycast
    defaults.CustomUserPreferences = {
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

    # Set Git commit hash for darwin-version.
    # configurationRevision = self.rev or self.dirtyRev or null;
  };

  nixpkgs = {
    # The platform the configuration will be used on.
    hostPlatform = "aarch64-darwin";
    config = {
      # Avoid programs alike vscode copilot unfree licensed to complain
      allowUnfree = true;
      # For broken packages use the following
      allowBroken = true;
    };
  };
}
