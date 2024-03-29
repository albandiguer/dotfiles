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
        ba = "branch -a";
        br = "branch";
        c = "commit";
        chunkyadd = "add --patch";
        ci = "commit";
        cih = "commit --reuse-message=HEAD";
        co = "checkout";
        cp = "cherry-pick";
        d = "difftool";
        dc = "diff --cached";
        fo = "fetch origin";
        l = "log --graph --date=short";
        last = "show HEAD";
        lpwd = "log -- ."; # git log for files in current directory
        nb = "checkout -b";
        ps = "push";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        reset = "reset HEAD";
        rup = "remote update --prune";
        rv = "remote --verbose";
        s = "status";
        sh = "show HEAD";
        shwo = "show";
        st = "status";
        unstage = "restore --staged";
        recent = "!f() { git reflog | egrep -io 'moving from ([^[:space:]]+)' | awk '{ print $3 }' | awk ' !x[$0]++' | head -n10 | fzf --reverse --bind 'enter:become(git checkout {})'; }; f";
      };
      github.user = "albandiguer";
      core.editor = "nvim";
      diff.tool = "nvim";
      add.interactive.useBuiltin = false;
      format.pretty = "format:%C(yellow)%h%C(reset) %C(green)%ad%C(reset) %C(blue)%an%C(reset) %s";
      # core.excludesfile = ".gitignore";
    };
    ignores = [
      "$XDG_CACHE_HOME/"
      "*.log"
      "*.swp"
      "*.tfstate.backup"
      "*~"
      ".DS_Store"
      ".Spotlight-V100"
      "._*"
      ".direnv/"
      ".gem/"
      ".gitignore"
      ".netrwhist"
      ".terraform/"
      ".use_ruby_ls"
      ".use_solargraph"
      ".vscode"
      ".zcompdump"
      "Session.vim"
      "gitmodules"
      "node_modules/"
      "secrets.tfvars"
      "tags"
    ];

    diff-so-fancy.enable = true;
    # difftastic.enable = true;
  };
}
