{
  programs.git = {
    enable = true;
    userName = "Alban Diguer";
    userEmail = "alban.diguer@gmail.com";
    extraConfig = {
      # colorUi = true;
      alias = {
        a = "add";
        aa = "add --all";
        amend = "commit --amend";
        b = "branch";
        br = "branch";
        c = "commit";
        chunkyadd = "add --patch";
        ci = "commit";
        co = "checkout";
        cp = "cherry-pick";
        d = "difftool";
        dc = "diff --cached";
        l = "log --graph --date=short";
        last = "show HEAD";
        lpwd = "log -- ."; # git log for files in current directory
        nb = "checkout -b";
        ps = "push";
        reset = "reset HEAD";
        s = "status";
        shwo = "show";
        st = "status";
        unstage = "restore --staged";
      };
      github.user = "albandiguer";
      diff.tool = "nvim";
      add.interactive.useBuiltin = false;
      format.pretty = "format:%C(yellow)%h%C(reset) %C(green)%ad%C(reset) %C(blue)%an%C(reset) %s";
      # core.excludesfile = ".gitignore";
    };
    ignores = [
      "*.swp"
      "*.tfstate.backup"
      "*~"
      ".DS_Store"
      "._*"
      ".gitignore"
      ".vscode"
      ".Spotlight-V100"
      "Session.vim"
      "gitmodules"
      "tags"
      "node_modules/"
      ".gem/"
      ".terraform/"
      ".netrwhist"
      ".zcompdump"
      "*.log"
      "$XDG_CACHE_HOME/"
    ];

    diff-so-fancy.enable = true;
    # difftastic.enable = true;
  };
}
