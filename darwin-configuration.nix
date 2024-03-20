{pkgs, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    eza
    fzf
    graphite-cli
    iredis
    marp-cli #https://github.com/marp-team/marp-cli
    openssl
    sqlite
  ];

  services = {
    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;

    yabai = {
      enable = true;
      config = {
        mouse_follows_focus = "off";
        focus_follows_mouse = "off";
        window_placement = "second_child";
        window_topmost = "off";
        window_opacity = "off";
        window_opacity_duration = "0.0";
        window_shadow = "off";
        window_border = "on";
        window_border_width = 1;
        active_window_border_color = "0xFF40FF00";
        normal_window_border_color = "0x00FFFFFF";
        active_window_opacity = 1.0;
        normal_window_opacity = 0.90;
        split_ratio = 0.50;
        auto_balance = "off";
        mouse_modifier = "fn";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        layout = "bsp";
        top_padding = 8;
        bottom_padding = 8;
        left_padding = 8;
        right_padding = 8;
        window_gap = 8;
      };
      extraConfig = ''
        yabai -m rule --add app="^1Password.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Asana.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Books.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Calendar.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Dash.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Discord.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Docker.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Finder.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Insomnia.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Licecap.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Maps.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Notes.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Notion.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Parallels\ Desktop.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Photo\ Booth.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Podcasts.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Postman.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Preview.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^QuickTime.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^RapidAPI.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Stocks.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^System.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Todoist.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Transmission.*$" sticky=on layer=above manage=off
        yabai -m rule --add app="^Weather.*$" sticky=on layer=above manage=off
      '';
    };
    skhd = {
      enable = true;
      skhdConfig = ''
        alt + cmd - h : yabai -m window --warp west
        alt + cmd - l : yabai -m window --warp east
        alt + cmd - k : yabai -m window --warp north
        alt + cmd - j : yabai -m window --warp south
        # maximize a window
        alt + cmd - f : yabai -m window --toggle zoom-fullscreen
        # balance out tree of windows (resize to occupy equal space)
        alt + cmd - b : yabai -m space --balance
        # rotate layout
        alt + cmd - r : yabai -m space --rotate 90
        # move windows prev/next space
        alt + cmd - left : yabai -m window --space prev; yabai -m window --focus west
        alt + cmd - right : yabai -m window --space next; yabai -m display --focus east
        # float / unfloat window and center on screen
        alt + cmd - t : yabai -m window --toggle float;\
        yabai -m window --grid 4:4:1:1:2:2
      '';
    };
    lorri = {
      enable = true;
    };
  };
  nix.package = pkgs.nix; # TODO figure what is it

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh.enable = true; # default shell on catalina
    direnv.enable = true;
  };
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  homebrew = {
    enable = true;
    brews = [
      "libpq"
      "libyaml"
      "iredis"
    ];
    casks = [
      "dash"
      "licecap"
      "monitorcontrol"
      "notion"
      "obsidian"
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
