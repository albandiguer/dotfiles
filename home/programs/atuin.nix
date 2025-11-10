{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;

    flags = [
      "--disable-up-arrow"
    ];

    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://api.atuin.sh";

      search_mode = "fuzzy";
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "session";

      style = "compact";
      show_preview = true;
      show_help = true;
      exit_mode = "return-original";

      history_filter = [
        "^ls"
        "^cd"
        "^pwd"
        "^exit"
        "^clear"
      ];

      secrets_filter = true;

      enter_accept = true;

      keymap_mode = "auto";
      keymap_cursor = {
        vim_insert = "steady-bar";
        vim_normal = "steady-block";
      };
    };
  };
}
