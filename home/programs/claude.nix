{
  rails-ai-agents,
  config,
  ...
}:
let
  # Default to "37signals_agents" for personal machine, override via CLAUDE_AGENTS_SUBFOLDER for work
  agentsSubfolder = config.home.sessionVariables.CLAUDE_AGENTS_SUBFOLDER or "37signals_agents";
in
{
  programs.claude-code = {
    enable = true;

    settings = {
      statusLine = {
        type = "command";
        command = "~/.claude/statusline-command.sh";
      };
      includeCoAuthoredBy = false;
      alwaysThinkingEnabled = true;
      voiceEnabled = true;
      enabledPlugins = {
        "dev-browser@dev-browser-marketplace" = true;
        "ast-grep@ast-grep-marketplace" = true;
        "lua-lsp@claude-plugins-official" = true;
        "github@claude-plugins-official" = true;
        "context7@claude-plugins-official" = true;
      };
      env = {
        CLAUDE_CODE_MAX_OUTPUT_TOKENS = "64000";
        MAX_THINKING_TOKENS = "31999";
      };
      hooks = {
        PreToolUse = [
          {
            matcher = "Bash";
            hooks = [
              {
                type = "command";
                command = "~/.claude/rtk-rewrite.sh";
              }
            ];
          }
        ];
      };

      permissions = {
        allow = [
          "Bash(bin/rspec:*)"
          "Bash(bundle exec rspec:*)"
          "Bash(bundle exec rubocop:*)"
          "Bash(bundle show:*)"
          "Bash(curl:*)"
          "Bash(export:*)"
          "Bash(find:*)"
          "Bash(gh:*)"
          "Bash(git:*)"
          "Bash(grep:*)"
          "Bash(ls:*)"
          "Bash(node:*)"
          "Bash(python3:*)"
          "Bash(ruby:*)"
          "Bash(tail:*)"
          "Read"
          "Search"
          "WebFetch(domain:github.com)"
          "WebFetch(domain:raw.githubusercontent.com)"
          "WebFetch(domain:api.github.com)"
          "WebFetch(domain:opencode.ai)"
          "mcp__claude_ai_Notion__notion-fetch"
          "mcp__serena__*"
        ];
      };
    };

    mcpServers = {
      serena = {
        command = "uvx";
        args = [
          "--from"
          "git+https://github.com/oraios/serena"
          "serena"
          "start-mcp-server"
          "--context=claude-code"
          "--project-from-cwd"
          "--open-web-dashboard"
          "False"
        ];
      };
    };

    # NOTE: disabled for now
    # agentsDir = "${rails-ai-agents}/${agentsSubfolder}";
  };

  # Statusline script
  home.file.".claude/statusline-command.sh" = {
    executable = true;
    text = ''
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
        parts+=("$(printf '\033[35m %s\033[0m' "$git_branch")")
      fi

      # Model (dim white)
      if [ -n "$model" ]; then
        parts+=("$(printf '\033[2m%s\033[0m' "$model")")
      fi

      # Context usage (yellow when > 70%, green otherwise)
      if [ -n "$used_pct" ]; then
        used_int=''${used_pct%.*}
        if [ "''${used_int:-0}" -ge 70 ] 2>/dev/null; then
          parts+=("$(printf '\033[33mctx %s%%\033[0m' "$used_pct")")
        else
          parts+=("$(printf '\033[32mctx %s%%\033[0m' "$used_pct")")
        fi
      fi

      printf '%s' "$(IFS=' '; echo "''${parts[*]}")"
    '';
  };

  # RTK hook script for token-efficient command rewriting
  home.file.".claude/rtk-rewrite.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # rtk-hook-version: 3
      # RTK Claude Code hook — rewrites commands to use rtk for token savings.
      # Requires: rtk >= 0.23.0, jq
      #
      # This is a thin delegating hook: all rewrite logic lives in `rtk rewrite`,
      # which is the single source of truth (src/discover/registry.rs).
      # To add or change rewrite rules, edit the Rust registry — not this file.
      #
      # Exit code protocol for `rtk rewrite`:
      #   0 + stdout  Rewrite found, no deny/ask rule matched → auto-allow
      #   1           No RTK equivalent → pass through unchanged
      #   2           Deny rule matched → pass through (Claude Code native deny handles it)
      #   3 + stdout  Ask rule matched → rewrite but let Claude Code prompt the user

      if ! command -v jq &>/dev/null; then
        echo "[rtk] WARNING: jq is not installed. Hook cannot rewrite commands. Install jq: https://jqlang.github.io/jq/download/" >&2
        exit 0
      fi

      if ! command -v rtk &>/dev/null; then
        echo "[rtk] WARNING: rtk is not installed or not in PATH. Hook cannot rewrite commands. Install: https://github.com/rtk-ai/rtk#installation" >&2
        exit 0
      fi

      # Version guard: rtk rewrite was added in 0.23.0.
      RTK_VERSION=$(rtk --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
      if [ -n "$RTK_VERSION" ]; then
        MAJOR=$(echo "$RTK_VERSION" | cut -d. -f1)
        MINOR=$(echo "$RTK_VERSION" | cut -d. -f2)
        if [ "$MAJOR" -eq 0 ] && [ "$MINOR" -lt 23 ]; then
          echo "[rtk] WARNING: rtk $RTK_VERSION is too old (need >= 0.23.0). Upgrade: cargo install rtk" >&2
          exit 0
        fi
      fi

      INPUT=$(cat)
      CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

      if [ -z "$CMD" ]; then
        exit 0
      fi

      REWRITTEN=$(rtk rewrite "$CMD" 2>/dev/null)
      EXIT_CODE=$?

      case $EXIT_CODE in
        0)
          [ "$CMD" = "$REWRITTEN" ] && exit 0
          ;;
        1)
          exit 0
          ;;
        2)
          exit 0
          ;;
        3)
          ;;
        *)
          exit 0
          ;;
      esac

      ORIGINAL_INPUT=$(echo "$INPUT" | jq -c '.tool_input')
      UPDATED_INPUT=$(echo "$ORIGINAL_INPUT" | jq --arg cmd "$REWRITTEN" '.command = $cmd')

      if [ "$EXIT_CODE" -eq 3 ]; then
        jq -n \
          --argjson updated "$UPDATED_INPUT" \
          '{
            "hookSpecificOutput": {
              "hookEventName": "PreToolUse",
              "updatedInput": $updated
            }
          }'
      else
        jq -n \
          --argjson updated "$UPDATED_INPUT" \
          '{
            "hookSpecificOutput": {
              "hookEventName": "PreToolUse",
              "permissionDecision": "allow",
              "permissionDecisionReason": "RTK auto-rewrite",
              "updatedInput": $updated
            }
          }'
      fi
    '';
  };

  # Symlink skills to Claude Code's global skills directory
  home.file.".claude/skills/find-skills" = {
    source = ../dotfiles/.agents/skills/find-skills;
    recursive = true;
  };
}
