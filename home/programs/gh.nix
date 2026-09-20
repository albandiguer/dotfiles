{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.diffnav ]; # git diff pager with file tree (used by gh-dash)

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
