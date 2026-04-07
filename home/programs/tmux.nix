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
    extraConfig = ''
      # set -ga terminal-overrides ",*col*:Tc"
      set-option -g default-command "fish"

      # open new terminals in the same working directory
      bind '"' split-window -c "#{pane_current_path}"
      bind '-' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind '|' split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind l select-layout main-vertical

      # unbind detach
      unbind-key -T prefix d

      # status line (thanks, Ju!)
      set-option -g pane-active-border-style fg=colour2
      set-option -g pane-border-style fg=colour238
      set-option -g status-bg colour0
      set-option -g status-fg colour7
      set-option -g status-interval 60
      set-option -g status-justify left
      set-option -g status-left '#[bg=colour2] #[bg=colour8] #[bg=colour0] #S '
      set-option -g status-left-length 50
      set-option -g status-right '#(gitmux -cfg ~/.gitmux.conf "#{pane_current_path}") %a %R #[bg=colour8] #[bg=colour2] #[]'
      set-option -g status-right-length 120
      set-window-option -g window-status-current-format '#[bg=colour8]#[fg=colour3] #I #[bg=colour7]#[fg=colour8] #W#[fg=colour0]#F #[bg=colour8]'
      set-window-option -g window-status-format '#[bg=colour8]#[fg=colour3] #I #[fg=colour15]#W#[fg=colour5]#F# '

      # Fix nvim :healthcheck
      set-option -sg escape-time 10
      set-option -g focus-events on

      # sesh recommended settings
      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
      set -g detach-on-destroy off  # don't exit from tmux when closing a session

      # sesh quality of life bindings
      bind-key "l" run-shell "sesh last"  # better last session switching
      bind-key "9" run-shell "sesh connect --root $(pwd)"  # connect to root session
      # bind-key "W" run-shell "sesh window \"$(sesh window | fzf-tmux -p 60%,50% --prompt '🪟  ')\""  # window picker

      # sesh session picker (prefix+f) - override default tmux switcher
      bind-key "f" run-shell "sesh connect \"$(
        sesh list --icons | fzf-tmux -p 80%,70% \\
          --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \\
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \\
          --bind 'tab:down,btab:up' \\
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \\
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \\
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \\
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \\
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \\
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \\
          --preview-window 'right:55%' \\
          --preview 'sesh preview {}'
      )\""
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
      # tmuxPlugins.fingers
    ];
  };
}
