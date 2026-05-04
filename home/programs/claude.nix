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
        "ruby-lsp@claude-plugins-official" = true;
        "github@claude-plugins-official" = true;
        "context7@claude-plugins-official" = true;
      };
      env = {
        CLAUDE_CODE_MAX_OUTPUT_TOKENS = "64000";
        MAX_THINKING_TOKENS = "31999";
        CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
      };
      hooks = {
        SessionStart = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "echo '/caveman full'";
              }
            ];
          }
        ];
        UserPromptSubmit = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "workmux set-window-status working";
              }
            ];
          }
        ];
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
        PostToolUse = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "workmux set-window-status working";
              }
            ];
          }
        ];
        Stop = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "workmux set-window-status done";
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
          "Bash(git checkout *)"
          "Bash(grep:*)"
          "Bash(gs --versionj)"
          "Bash(gs branch *)"
          "Bash(gs log *)"
          "Bash(gs upstack *)"
          "Bash(ls:*)"
          "Bash(mise exec *)"
          "Bash(node:*)"
          "Bash(python3:*)"
          "Bash(rtk gh pr diff *)"
          "Bash(rtk gh pr view *)"
          "Bash(rtk read *)"
          "Bash(rtk rubocop *)"
          "Bash(ruby:*)"
          "Bash(tail:*)"
          "Read"
          "Search"
          "Skill(linear-cli)"
          "WebFetch(domain:api.github.com)"
          "WebFetch(domain:github.com)"
          "WebFetch(domain:opencode.ai)"
          "WebFetch(domain:raw.githubusercontent.com)"
          "mcp__claude_ai_Notion__notion-fetch"
          "mcp__plugin_context7_context7__query-docs"
          "mcp__plugin_context7_context7__resolve-library-id"
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

  # Symlink skills lock file to repo — npx skills add writes here directly
  home.file.".agents/.skill-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/albandiguer/dev/dotfiles/home/dotfiles/.agents/.skill-lock.json";
}
