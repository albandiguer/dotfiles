{
  pkgs,
  gh-enhance,
  ...
}:
let
  gh-enhance-pkg = pkgs.buildGoModule {
    pname = "gh-enhance";
    version = "latest";
    src = gh-enhance;
    vendorHash = "sha256-22MJ95wHwFbb9VDIc/pabOadn+gZsDD0czyKMvnwHXo=";

    # Ignore the vendor directory in source and generate fresh vendor from go.mod
    proxyVendor = true;
  };
in
{
  xdg.configFile."gh-dash/config.yml".source = ../dotfiles/gh-dash/config.yml;

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      github-copilot-cli
      gh-dash
      gh-enhance-pkg
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
