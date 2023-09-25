{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    keyMode = "vi";
    # https://github.com/nix-community/home-manager/blob/a88df2fb101778bfd98a17556b3a2618c6c66091/modules/programs/tmux.nix#L275C9-L275C9
    shell = "${pkgs.fish}/bin/fish"; # set $SHELL
    terminal = "xterm-256color"; # set $TERM
    mouse = true;
    historyLimit = 25000;
    extraConfig = ''
      # set -ga terminal-overrides ",*col*:Tc"

      # open new terminals in the same working directory
      bind '"' split-window -c "#{pane_current_path}"
      bind '-' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind '|' split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind l select-layout main-vertical
      bind f display-popup -E "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"

      # unbind detach
      unbind-key -T prefix d

      # status line (thanks, Ju!)
      set-option -g status-justify left
      set-option -g status-left '#[bg=colour2] #[bg=colour8] #[bg=colour0] #S '
      set-option -g status-left-length 16
      set-option -g status-fg colour7
      set-option -g status-bg colour0
      set-option -g status-right '%a %R #[bg=colour8] #[bg=colour2] #[]'
      set-option -g status-interval 60
      set-option -g pane-active-border-style fg=colour2
      set-option -g pane-border-style fg=colour238
      set-window-option -g window-status-format '#[bg=colour8]#[fg=colour3] #I #[fg=colour15]#W#[fg=colour5]#F# '
      set-window-option -g window-status-current-format '#[bg=colour8]#[fg=colour3] #I #[bg=colour7]#[fg=colour8] #W#[fg=colour0]#F #[bg=colour8]'
    '';

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      tmuxPlugins.vim-tmux-navigator # navigate split panes with C-{h/j/k/l}
      tmuxPlugins.yank
    ];
  };
}
