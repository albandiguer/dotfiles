{
  description = "Alban Diguer's nix config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
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
    self,
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
    hostname = "Albans-MacBook-Air"; # scutil --get LocalHostName|pbcopy
    m1Architecture = ["aarch64-darwin"];
    forAllArchitectures = f: nixpkgs.lib.genAttrs darwinSystems f;
  in {
    devShells = let
      pkgs = nixpkgs.legacyPackages.${m1Architecture};
    in {
      default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [bashInteractive git];
        shellHook = with pkgs; ''
          export EDITOR='nvim'
        '';
      };
    };
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      modules = [
        ./darwin-configuration.nix
      ];
    };
  };
}
