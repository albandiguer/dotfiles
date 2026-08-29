{ config, ... }:
{
  programs.claude-code = {
    enable = true;

    settings = {
      model = "claude-opus-4-8";
      effortLevel = "xhigh";
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
        "ponytail@ponytail" = true;
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
          "Bash(gem which *)"
          "Bash(git checkout *)"
          "Bash(gs --version)"
          "Bash(gs bc *)"
          "Bash(gs branch *)"
          "Bash(gs log *)"
          "Bash(gs ls:*)"
          "Bash(gs upstack *)"
          "Bash(mise exec *)"
          "Bash(node:*)"
          "Bash(python3:*)"
          "Bash(rtk aws sts get-caller-identity *)"
          "Bash(rtk gh checks *)"
          "Bash(rtk gh pr diff *)"
          "Bash(rtk gh pr edit *)"
          "Bash(rtk gh pr status *)"
          "Bash(rtk gh pr view *)"
          "Bash(rtk gh run view *)"
          "Bash(rtk git --no-pager diff *)"
          "Bash(rtk git branch *)"
          "Bash(rtk git diff *)"
          "Bash(rtk git log *)"
          "Bash(rtk git show *)"
          "Bash(rtk git status)"
          "Bash(rtk make rspec *)"
          "Bash(rtk rubocop *)"
          "Bash(rtk wc *)"
          "Bash(ruby:*)"
          "Bash(tail:*)"
          "Bash(tmux show-options *)"
          "Skill(linear-cli)"
          "WebFetch(domain:api.github.com)"
          "WebFetch(domain:github.com)"
          "WebFetch(domain:opencode.ai)"
          "WebFetch(domain:raw.githubusercontent.com)"
          "WebSearch"
          "mcp__claude_ai_Notion__notion-fetch"
          "mcp__plugin_context7_context7__query-docs"
          "mcp__plugin_context7_context7__resolve-library-id"
          "mcp__serena__*"
        ];
        # — force file ops through Serena MCP.
        deny = [
          "Read"
          "Write"
          "Edit"
          "Grep"
          "Glob"
          "LS"
        ];
      };
    };

    # ponytail: pydantic V1 breaks on python 3.14, pin to 3.12
    mcpServers = {
      serena = {
        command = "uvx";
        args = [
          "--python"
          "3.12"
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
