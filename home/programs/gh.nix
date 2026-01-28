{
  pkgs,
  ...
}:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ github-copilot-cli ];
    settings = {
      aliases = {
        pcd = "pr create --draft";
        pvw = "pr view --web";
        s = "status";
      };
    };
  };
}
