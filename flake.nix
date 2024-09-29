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
    homebrew-puma-tap = {
      url = "github:puma/homebrew-puma";
      flake = false;
    };
    hashicorp-tap = {
      url = "github:hashicorp/homebrew-tap";
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
    homebrew-puma-tap,
    hashicorp-tap,
    ...
  } @ inputs: let
    user = "albandiguer";
    overlays = [inputs.neovim-nightly-overlay.overlays.default];
    commonDarwinModules = [
      ./darwin/macbook.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import ./home/users/${user}/home.nix;
        users.users.${user} = {
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
            "puma/homebrew-puma" = homebrew-puma-tap;
            # "hashicorp/tap" = hashicorp-tap;
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
    # TODO: here we put everything in that darwin config when it shall be split and more granular
    # see https://github.com/Kidsan/nixos-config/blob/main/flake.nix
    darwinConfigurations = {
      # name figured with `scutil --get LocalHostName|pbcopy`
      Albans-MacBook-Air = darwin.lib.darwinSystem {modules = commonDarwinModules;};
      Albans-MacBook-Pro = darwin.lib.darwinSystem {
        modules =
          commonDarwinModules
          ++ [
            {home-manager.users.${user}.programs.git.userEmail = nixpkgs.lib.mkForce "alban.diguer@pretto.fr";}
            {home-manager.users.${user}.home.sessionVariables.OBSIDIAN_VAULT_PATH = "/Users/albandiguer/Google Drive/My Drive/obsidian_vaults/Reliable Brain";}
          ];
      };
    };
  };
}
