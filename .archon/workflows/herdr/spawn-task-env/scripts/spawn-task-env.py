#!/usr/bin/env python3
"""Spawn a Herdr workspace for a task: git worktree + editor, pi, tuicr tabs.

Reads the task/branch/base/editor from INPUTS_* / ARGUMENTS env vars (Archon
injects them; user-controlled values arrive as env, never as code).
"""

import json
import os
import re
import secrets
import subprocess
import sys


def run(*args):
    r = subprocess.run(args, capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(f"$ {' '.join(args)}\n{r.stderr.strip() or r.stdout.strip()}")
    if not r.stdout.strip():
        return {}
    data = json.loads(r.stdout)
    return data.get("result", data) if isinstance(data, dict) else data


def slugify(text, n=32):
    s = re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")
    return s[:n].rstrip("-") or "task"


def repo_source_checkout():
    """Herdr starts worktree actions from the repo's MAIN checkout, so when the
    run lives in a linked worktree (archon's default isolation), hand herdr the
    main checkout path instead of our own cwd."""
    common = subprocess.run(
        ["git", "rev-parse", "--path-format=absolute", "--git-common-dir"],
        capture_output=True,
        text=True,
    ).stdout.strip()
    if common.endswith("/.git"):
        return common[: -len("/.git")]
    return os.getcwd()


def main():
    task = (os.environ.get("INPUTS_TASK") or os.environ.get("ARGUMENTS", "")).strip()
    if not task:
        sys.exit("no task: pass --input task=... or include it in the message")
    # herdr's agent-start rejects control chars in args — collapse multi-line
    # task text to a single line before handing it over
    task = " ".join(task.split())
    # default policy: no commits — the user reviews the diff in tuicr first
    task += " Policy: do NOT commit, push, or create commits. Leave all changes "
    task += "uncommitted in the working tree for review."

    branch = os.environ.get("INPUTS_BRANCH") or f"task/{slugify(task)}"
    editor = os.environ.get("INPUTS_EDITOR") or os.environ.get("EDITOR") or "nvim"
    base = os.environ.get("INPUTS_BASE") or None

    create = [
        "herdr",
        "worktree",
        "create",
        "--cwd",
        repo_source_checkout(),
        "--branch",
        branch,
        "--label",
        f"task: {task[:48]}",
        "--no-focus",
    ]
    if base:
        create += ["--base", base]
    res = run(*create)
    ws = res["workspace"]["workspace_id"]
    path = res["workspace"]["worktree"]["checkout_path"]

    try:
        # editor lives in the worktree's root tab — exactly 3 tabs total:
        # editor, pi, tuicr (no extra shell tab)
        run("herdr", "tab", "rename", res["tab"]["tab_id"], "editor")
        run("herdr", "pane", "run", res["root_pane"]["pane_id"], editor)

        # pi tab — the task, already pointed at the worktree
        t = run(
            "herdr",
            "tab",
            "create",
            "--workspace",
            ws,
            "--cwd",
            path,
            "--label",
            "pi",
            "--no-focus",
        )
        agent = f"pi-{secrets.token_hex(4)}"
        run(
            "herdr",
            "agent",
            "start",
            agent,
            "--kind",
            "pi",
            "--pane",
            t["root_pane"]["pane_id"],
            "--",
            task,
        )

        # tuicr tab — live working-tree diff. tuicr errors out on an empty
        # working tree, so wait for the pi agent's first change before launching
        t = run(
            "herdr",
            "tab",
            "create",
            "--workspace",
            ws,
            "--cwd",
            path,
            "--label",
            "tuicr",
            "--no-focus",
        )
        run(
            "herdr",
            "pane",
            "run",
            t["root_pane"]["pane_id"],
            'echo "waiting for changes..."; while [ -z "$(git status --porcelain)" ]; do sleep 5; done; tuicr -w',
        )
    except BaseException:
        # failed before the pi agent was launched — nothing of value is in the
        # fresh worktree, remove it rather than leaving stray litter
        subprocess.run(
            ["herdr", "worktree", "remove", "--workspace", ws, "--force"],
            capture_output=True,
        )
        raise

    print(f"worktree: {path} (branch {branch})")
    print(f"workspace: {ws}")
    print(f"editor tab: {editor}")
    print(f"pi agent: {agent} — {task}")
    print(f"tuicr tab: live working-tree diff")


if __name__ == "__main__":
    main()
