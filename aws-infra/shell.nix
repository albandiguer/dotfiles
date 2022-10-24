{ sources ? import nix/sources.nix }:
let
  pkgs = import sources.nixpkgs { };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    terraform
    # terraform-providers.aws
    terraform-docs
    tfsec # security scanner for terraform https://github.com/aquasecurity/tfsec
    graphviz # to visualize graph
  ];

  AWS_PROFILE = "default";
}
