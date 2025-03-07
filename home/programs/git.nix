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
        amf = "commit --amend --no-edit";
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
        dib = "!f() { git merge-base $(git rev-parse --abbrev-ref origin/HEAD) HEAD | xargs -I _ git diff _ -- $1; }; f";
        fo = "fetch origin";
        frbo = "!f() { git fetch origin && git rev-parse --abbrev-ref origin/HEAD | xargs git rebase $1; }; f";
        l = "log --graph --date=short";
        last = "show HEAD";
        lpwd = "log -- ."; # git log for files in current directory
        nb = "checkout -b";
        ps = "push";
        pushtostaging = "push origin HEAD:staging";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        rbo = "!f() { git rev-parse --abbrev-ref origin/HEAD | xargs git rebase $1; }; f";
        recent = "!f() { git reflog | egrep -io 'moving from ([^[:space:]]+)' | awk '{ print $3 }' | awk ' !x[$0]++' | head -n30 | fzf --reverse --bind 'enter:become(git checkout {})'; }; f";
        reset = "reset HEAD";
        ri = "!f() { git merge-base $(git rev-parse --abbrev-ref origin/HEAD) HEAD | xargs git rebase -i; }; f";
        rup = "remote update --prune";
        rv = "remote --verbose";
        s = "status";
        sh = "show";
        shwo = "show";
        st = "status";
        unstage = "restore --staged";
      };
      github.user = "albandiguer";
      init.defaultBranch = "main";
      core.editor = "nvim";
      diff.tool = "nvim";
      add.interactive.useBuiltin = false;
      rebase.updateRefs = true;
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
      ".nvim.lua"
      ".terraform/"
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
