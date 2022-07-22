{pkgs ? import <nixpkgs> {}}:
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
