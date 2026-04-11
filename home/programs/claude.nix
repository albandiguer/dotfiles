{ config, ... }:
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
  };

  # Statusline script
  home.file.".claude/statusline-command.sh" = {
    executable = true;
    source = ./claude/statusline-command.sh;
  };

  # RTK hook script for token-efficient command rewriting
  home.file.".claude/rtk-rewrite.sh" = {
    executable = true;
    source = ./claude/rtk-rewrite.sh;
  };

  # Symlink global skills lock file to repo (editable by skills CLI)
  home.file.".agents/.skill-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/albandiguer/dev/dotfiles/home/dotfiles/.agents/.skill-lock.json";
}
