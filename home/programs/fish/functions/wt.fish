if test (count $argv) -ge 2; and test $argv[1] = "create"
    # Get worktrees before creation
    set -l before_worktrees (git worktree list --porcelain 2>/dev/null | grep "^worktree" | string replace "worktree " "")

    # Create the worktree
    command wt switch -c $argv[2] --no-cd
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
