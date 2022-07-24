{sources ? import nix/sources.nix}: let
  pkgs = import sources.nixpkgs {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      terraform
      # terraform-providers.aws
      terraform-docs
      tfsec
    ];

    AWS_PROFILE = "default";
    AWS_REGION = "ap-southeast-2";
  }
