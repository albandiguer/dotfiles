{
  pkgs,
  ...
}:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-copilot ];
    settings = {
      aliases = {
        pcd = "pr create --draft";
        pvw = "pr view --web";
      };
    };
  };
}
