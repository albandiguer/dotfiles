{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false; # NOTE not working with fish (reattach to user namespace? https://github.com/tmux-plugins/tmux-sensible/blob/master/sensible.tmux)
    keyMode = "vi";
    # https://github.com/nix-community/home-manager/blob/a88df2fb101778bfd98a17556b3a2618c6c66091/modules/programs/tmux.nix#L275C9-L275C9
    shell = "${pkgs.fish}/bin/fish"; # set $SHELL
    terminal = "tmux-256color"; # set $TERM
    mouse = true;
    historyLimit = 25000;
    extraConfig = builtins.readFile ./tmux.conf;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      tmuxPlugins.vim-tmux-navigator # navigate split panes with C-{h/j/k/l}
      tmuxPlugins.yank
      # tmuxPlugins.fingers
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_status_modules_right "gitmux session date_time"
          set -g @catppuccin_date_time_text "%a %R"
          set -g @catppuccin_gitmux_text '#(gitmux -cfg ~/.gitmux.conf "#{pane_current_path}")'
        '';
      }
    ];
  };
}
