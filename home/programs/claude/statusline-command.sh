#!/usr/bin/env bash
# Claude Code status line - inspired by Starship prompt defaults

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir=$(basename "$cwd")
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Git branch (skip optional locks)
git_branch=""
if git_dir=$(git -C "$cwd" rev-parse --git-dir 2>/dev/null); then
	git_branch=$(git -C "$cwd" -c gc.auto=0 symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" -c gc.auto=0 rev-parse --short HEAD 2>/dev/null)
fi

# Build parts
parts=()

# Directory (cyan)
parts+=("$(printf '\033[36m%s\033[0m' "$dir")")

# Git branch (magenta)
if [ -n "$git_branch" ]; then
	parts+=("$(printf '\033[35m%s\033[0m' "$git_branch")")
fi

# Model (dim white)
if [ -n "$model" ]; then
	parts+=("$(printf '\033[2m%s\033[0m' "$model")")
fi

# Context usage (yellow when > 70%, green otherwise)
if [ -n "$used_pct" ]; then
	used_int=${used_pct%.*}
	if [ "${used_int:-0}" -ge 70 ] 2>/dev/null; then
		parts+=("$(printf '\033[33mctx %s%%\033[0m' "$used_pct")")
	else
		parts+=("$(printf '\033[32mctx %s%%\033[0m' "$used_pct")")
	fi
fi

# Rate limits (5-hour and 7-day)
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
rate_parts=()
if [ -n "$five_pct" ]; then
	five_int=$(printf '%.0f' "$five_pct")
	if [ "${five_int:-0}" -ge 70 ] 2>/dev/null; then
		rate_parts+=("$(printf '\033[33m5h:%s%%\033[0m' "$five_int")")
	else
		rate_parts+=("$(printf '\033[32m5h:%s%%\033[0m' "$five_int")")
	fi
fi
if [ -n "$week_pct" ]; then
	week_int=$(printf '%.0f' "$week_pct")
	if [ "${week_int:-0}" -ge 70 ] 2>/dev/null; then
		rate_parts+=("$(printf '\033[33m7d:%s%%\033[0m' "$week_int")")
	else
		rate_parts+=("$(printf '\033[32m7d:%s%%\033[0m' "$week_int")")
	fi
fi
if [ ${#rate_parts[@]} -gt 0 ]; then
	parts+=("$(
		IFS='/'
		echo "${rate_parts[*]}"
	)")
fi

printf '%s' "$(
	IFS=' '
	echo "${parts[*]}"
)"
