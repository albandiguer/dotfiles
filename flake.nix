{
  description = "Alban Diguer's nix config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-darwin.follows = "darwin";
      };
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    darwin,
    nix-homebrew,
    homebrew-bundle,
    homebrew-core,
    homebrew-cask,
    ...
  } @ inputs: let
    user = "albandiguer";
    overlays = [inputs.neovim-nightly-overlay.overlay];
    commonDarwinModules = [
      ./darwin-configuration.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./previously/home.nix;
        users.users.albandiguer = {
          name = user;
          home = "/Users/albandiguer";
        };
      }
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          inherit user;
          enable = true;
          taps = {
            "homebrew/homebrew-core" = homebrew-core;
            "homebrew/homebrew-cask" = homebrew-cask;
            "homebrew/homebrew-bundle" = homebrew-bundle;
          };
          mutableTaps = false;
          autoMigrate = true;
        };
      }
      {
        nixpkgs.overlays = overlays;
      }
    ];
  in {
    darwinConfigurations = {
      # name figured with `scutil --get LocalHostName|pbcopy`
      Albans-MacBook-Air = darwin.lib.darwinSystem {modules = commonDarwinModules;};
      Albans-MacBook-Pro = darwin.lib.darwinSystem {
        modules =
          commonDarwinModules
          ++ [
            {home-manager.users.${user}.programs.git.userEmail = nixpkgs.lib.mkForce "alban.diguer@pretto.fr";}
          ];
      };
    };
  };
}
