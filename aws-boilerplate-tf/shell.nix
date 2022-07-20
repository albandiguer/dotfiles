let
  # List of available packages/versions here
  # https://lazamar.co.uk/nix-versions/?package=terraform&version=0.13.7&fullName=terraform-0.13.7&keyName=terraform_0_13&revision=bf972dc380f36a3bf83db052380e55f0eaa7dcb6&channel=nixpkgs-unstable#instructions
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bf972dc380f36a3bf83db052380e55f0eaa7dcb6.tar.gz";
  }) {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      terraform_0_13
      tfsec
    ];

    AWS_PROFILE = "default";
    AWS_REGION = "ap-southeast-2";
  }
