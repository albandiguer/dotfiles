{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = false;
    # package = pkgs.vscodium; # oss vscode not work with Copilot

    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      # esbenp.prettier-vscode
      github.copilot
      hashicorp.terraform
      ms-toolsai.jupyter
      marp-team.marp-vscode
      # ms-vsliveshare.vsliveshare
    ];
    # ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
    #   name = "castwide.solargraph";
    #   publisher = "castwide";
    #   version = "v0.24.0";
    #   sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    # }];

    # ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
    #   name = "catpuccin.catpuccin-vsc";
    #   publisher = "Catpuccin";
    #   version = "v1.0.6";
    #   sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    # }];
  };
}
