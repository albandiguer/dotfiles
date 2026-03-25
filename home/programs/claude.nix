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

  # Symlink skills to Claude Code's global skills directory
  home.file.".claude/skills/find-skills" = {
    source = ../dotfiles/.agents/skills/find-skills;
    recursive = true;
  };
}
