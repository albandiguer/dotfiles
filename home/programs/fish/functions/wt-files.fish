argparse 't/target=' 'h/help' -- $argv
or return 1

if set -q _flag_help
    echo "wt-files — populate a git worktree with local-only files from the main worktree"
    echo ""
    echo "Git worktrees start empty of untracked/gitignored files (.env, node_modules, etc.)."
    echo "This function finds those files in the main worktree and symlinks or copies them"
    echo "into the target worktree at the same relative path. Monorepo-aware: it searches"
    echo "recursively so every package's .env or node_modules gets wired up. Idempotent:"
    echo "safe to run multiple times — skips correct symlinks, fixes broken ones."
    echo ""
    echo "Usage: wt-files [-t <path>] [filter...]"
    echo ""
    echo "Options:"
    echo "  -t, --target <path>   Worktree to populate (default: current directory)"
    echo "  -h, --help            Show this help"
    echo ""
    echo "Filters (optional):"
    echo "  Restrict to entries whose relative path contains the given string."
    echo "  Pass a filename (.env) to target that file everywhere, or a directory"
    echo "  name (frontend) to only process files under that subtree."
    echo ""
    echo "Configured files:"
    echo "  symlink  .env, .envrc, .nvim.lua, mise.local.toml, .workmux.yaml, node_modules/"
    echo "  copy     .claude/settings.local.json"
    echo ""
    echo "Examples:"
    echo "  wt-files                        # setup everything in current worktree"
    echo "  wt-files -t ../other-branch     # setup a specific worktree"
    echo "  wt-files .env                   # only .env files (all packages)"
    echo "  wt-files node_modules           # only node_modules symlinks"
    echo "  wt-files frontend               # only files under a frontend/ directory"
    return 0
end

set -l copy_files \
    ".claude/settings.local.json"

set -l symlink_files \
    ".env" \
    ".envrc" \
    ".nvim.lua" \
    "mise.local.toml" \
    ".workmux.yaml" \
    "node_modules"

set -l target (realpath .)
set -q _flag_target
and set target (realpath -- $_flag_target)

set -l filters $argv

set -l main_worktree (git -C $target worktree list --porcelain 2>/dev/null | head -1 | string replace 'worktree ' '')

if test -z "$main_worktree"
    echo "wt-files: not in a git repository"
    return 1
end

set main_worktree (realpath -- $main_worktree)

if test "$target" = "$main_worktree"
    echo "wt-files: target is the main worktree, nothing to setup"
    return 1
end

echo "source: $main_worktree"
echo "target: $target"
if test (count $filters) -gt 0
    echo "filter: $filters"
end

for pat in $symlink_files $copy_files
    set -l mode symlink
    contains -- $pat $copy_files
    and set mode copy

    set -l bname (path basename $pat)

    for src in (find $main_worktree -name "$bname" -not -path "*/.git/*" -not -path "*/node_modules/*" 2>/dev/null)
        set -l rel (string replace -- "$main_worktree/" "" $src)

        # For path patterns (e.g. .claude/settings.local.json), verify the suffix matches
        if string match -q "*/*" -- $pat
            string match -q "*$pat" -- $rel
            or continue
        end

        # Apply filters: skip if rel path doesn't contain any filter string
        if test (count $filters) -gt 0
            set -l match false
            for f in $filters
                if string match -q "*$f*" -- $rel
                    set match true
                    break
                end
            end
            test $match = true
            or continue
        end

        set -l dst "$target/$rel"

        mkdir -p (path dirname $dst)

        if test $mode = symlink
            if test -L $dst
                # Symlink exists — check if it already points to the right place
                if test (readlink $dst) = $src
                    # Already correct, nothing to do
                else if test -e $dst
                    echo "  warn $rel → points to "(readlink $dst)
                else
                    # Broken symlink — recreate it
                    rm $dst
                    ln -s $src $dst
                    echo "  fix $rel (was broken)"
                end
            else if test -e $dst
                echo "  warn $rel (regular file exists, skipping)"
            else
                ln -s $src $dst
                echo "  symlink $rel"
            end
        else
            if test -e $dst
                # Already exists, nothing to do
            else
                cp $src $dst
                echo "  copy $rel"
            end
        end
    end
end
