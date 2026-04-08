if test (count $argv) -ge 2; and test $argv[1] = "create"
    # Build worktree path: parent/repo-name.subpath.branch
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    set -l repo_name (basename $repo_root)
    set -l parent_dir (dirname $repo_root)
    set -l current (pwd)
    set -l branch $argv[2]
    set -l worktree_path

    if test "$current" = "$repo_root"
        set worktree_path "$parent_dir/$repo_name.$branch"
    else
        set -l rel_path (string replace "$repo_root/" "" "$current")
        set -l rel_sanitized (string replace -ra '/' '-' $rel_path)
        set worktree_path "$parent_dir/$repo_name-$rel_sanitized.$branch"
    end

    # Get worktrees before creation
    set -l before_worktrees (git worktree list --porcelain 2>/dev/null | grep "^worktree" | string replace "worktree " "")

    # Create the worktree at the computed path
    WORKTRUNK_WORKTREE_PATH=$worktree_path command wt switch -c $argv[2] --no-cd
    set -l wt_status $status

    # If successful, add new worktree to zoxide
    if test $wt_status -eq 0
        set -l after_worktrees (git worktree list --porcelain 2>/dev/null | grep "^worktree" | string replace "worktree " "")
        for wt_path in $after_worktrees
            if not contains $wt_path $before_worktrees
                zoxide add $wt_path
                break
            end
        end
    end
else
    command wt $argv
end
