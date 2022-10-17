{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      set -ga terminal-overrides ",*col*:Tc"
      # get rid of the half-second escape time for kakoune's escape key
      set -sg escape-time 25

      # mouse
      set -g mouse on

      # increase history size
      set -g history-limit 25000


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
