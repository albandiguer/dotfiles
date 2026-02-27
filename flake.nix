{
  description = "Alban Diguer's nix config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    claude-code.url = "github:sadjow/claude-code-nix";
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
    homebrew-sfmono-nerd-font = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
    rails-ai-agents = {
      url = "github:ThibautBaissac/rails_ai_agents";
      flake = false;
    };
    try.url = "github:tobi/try";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      darwin,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      homebrew-puma-tap,
      hashicorp-tap,
      homebrew-sfmono-nerd-font,
      rails-ai-agents,
      claude-code,
      ...
    }@inputs:
    let
      user = "albandiguer";
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        inputs.claude-code.overlays.default
      ];
      commonDarwinModules = [
        ./darwin/macbook.nix
        home-manager.darwinModules.home-manager
        {
          system.primaryUser = user;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit rails-ai-agents;
            try = inputs.try;
          };
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
              "shaunsingh/SFMono-Nerd-Font-Ligaturized" = homebrew-sfmono-nerd-font;
            };
            mutableTaps = false;
            autoMigrate = true;
          };
        }
        {
          nixpkgs.overlays = overlays;
        }
      ];
    in
    {
      # TODO: here we put everything in that darwin config when it shall be split and more granular
      # see https://github.com/Kidsan/nixos-config/blob/main/flake.nix
      darwinConfigurations = {
        # name figured with `scutil --get LocalHostName|pbcopy`
        Albans-MacBook-Air = darwin.lib.darwinSystem { modules = commonDarwinModules; };
        Prettos-MacBook-Pro = darwin.lib.darwinSystem {
          modules = commonDarwinModules ++ [ ./specifics/pretto.nix ];
        };
      };
    };
}
