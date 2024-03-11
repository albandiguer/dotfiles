{
  description = "Alban Diguer's nix config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
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
    hostnames = ["Albans-MacBook-Air"]; # scutil --get LocalHostName|pbcopy
    architecture = "aarch64-darwin";
    forAllHostnames = f: nixpkgs.lib.genAttrs hostnames f; # https://teu5us.github.io/nix-lib.html#lib.attrsets.genattrs
  in {
    # devShells = let
    #   pkgs = nixpkgs.legacyPackages.${m1Architecture};
    # in {
    #   default = pkgs.mkShell {
    #     nativeBuildInputs = with pkgs; [bashInteractive git];
    #     shellHook = with pkgs; ''
    #       export EDITOR='nvim'
    #     '';
    #   };
    # };
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Albans-MacBook-Air
    darwinConfigurations =
      forAllHostnames
      (
        hostname:
          darwin.lib.darwinSystem {
            # inherit hostname;
            # https://github.com/LnL7/nix-darwin?tab=readme-ov-file#using-flake-inputs
            # specialArgs = inputs;
            modules = [
              ./darwin-configuration.nix
              home-manager.darwinModules.home-manager
              {
                # By default, Home Manager uses a private pkgs instance that is configured via the home-manager.users..nixpkgs options. To instead use the global pkgs that is configured via the system level nixpkgs options, set home-manager.useGlobalPkgs = true; This saves an extra Nixpkgs evaluation, adds consistency, and removes the dependency on NIX_PATH, which is otherwise used for importing Nixpkgs.
                home-manager.useGlobalPkgs = true;
                # By default packages will be installed to $HOME/.nix-profile but they can be installed to /etc/profiles if home-manager.useUserPackages = true; is added to the system configuration. This is necessary if, for example, you wish to use nixos-rebuild build-vm. This option may become the default value in the future.
                home-manager.useUserPackages = true;
                home-manager.users.albandiguer = import ./previously/home.nix;
                users.users.albandiguer.name = "albandiguer";
                users.users.albandiguer.home = "/Users/albandiguer";
                # Optionally, use home-manager.extraSpecialArgs to pass
                # arguments to home.nix
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
            ];
          }
      );
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Albans-MacBook-Air".pkgs;
  };
}
