#!/usr/bin/env python3
"""Wrapper around 'sesh list --icons' that colors worktrees amber and regular tmux sessions bright blue."""
import json, re, subprocess, sys

AMBER = "\033[38;5;214m"   # worktrees
BLUE  = "\033[38;5;75m"    # regular tmux sessions
RESET = "\033[0m"
ANSI = re.compile(r"\x1b\[[0-9;]*m")

flags = sys.argv[1:]

sessions = json.loads(
    subprocess.run(
        ["sesh", "list", "--json"] + flags, capture_output=True, text=True
    ).stdout
    or "[]"
)
lines = subprocess.run(
    ["sesh", "list", "--icons"] + flags, capture_output=True, text=True
).stdout.splitlines()

for s, l in zip(sessions, lines):
    if s.get("Src") != "tmux":
        print(l)
        continue
    color = AMBER if "__worktrees" in s.get("Path", "") else BLUE
    print(color + ANSI.sub("", l) + RESET)

# If JSON/lines counts differ, emit any remaining lines unchanged.
for l in lines[len(sessions):]:
    print(l)
