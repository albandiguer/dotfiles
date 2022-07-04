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
        nb = "checkout -b";
        ps = "push";
        reset = "reset HEAD";
        s = "status";
        shwo = "show";
        st = "status";
      };
      github.user = "albandiguer";
      diff.tool = "nvim";
      format.pretty = "format:%C(yellow)%h%C(reset) %C(green)%ad%C(reset) %C(blue)%an%C(reset) %s";
      core.excludesfile = ".gitignore";
    };
  };
}
