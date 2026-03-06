{
  pkgs,
  lib,
  ...
}:
{
  home.activation.gh-extensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.gh}/bin/gh extension install dlvhdr/gh-enhance 2>/dev/null || true
  '';

  xdg.configFile."gh-dash/config.yml".source = ../dotfiles/gh-dash/config.yml;

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      github-copilot-cli
      gh-dash
    ];
    settings = {
      aliases = {
        pcd = "pr create --draft";
        pvw = "pr view --web";
        s = "status";
      };
    };
  };
}
