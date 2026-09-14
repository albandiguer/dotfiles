{ pkgs, ... }:
{
  home.packages = [ pkgs.tuicr ];

  # tuicr resolves bundled theme names first and only then looks for local files
  # in `$XDG_CONFIG_HOME/tuicr/themes/`. `catppuccin-mocha` is bundled, so no
  # local theme file is needed (and a local file with the same name would lose).
  xdg.configFile."tuicr/config.toml".source =
    (pkgs.formats.toml { }).generate "tuicr-config.toml"
      {
        theme = "catppuccin-mocha";
        editor = "nvim";

        comment_types = [
          {
            id = "note";
            label = "question";
            definition = "ask for clarification";
            color = "#f9e2af"; # mocha yellow
          }
          {
            id = "suggestion";
            definition = "possible improvements";
            color = "#89b4fa"; # mocha blue
          }
          {
            id = "issue";
            definition = "problems to fix";
            color = "#f38ba8"; # mocha red
          }
          {
            id = "praise";
            definition = "positive feedback";
            color = "#a6e3a1"; # mocha green
          }
          {
            id = "nit";
            label = "nitpick";
            definition = "small optional tweaks";
            color = "#fab387"; # mocha peach
          }
        ];
      };
}
