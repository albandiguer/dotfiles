{ config, ... }:
{
  programs.claude-code = {
    enable = true;

    settings = {
      model = "claude-opus-4-8";
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
          "Bash(diffity *)"
          "Bash(export:*)"
          "Bash(find:*)"
          "Bash(gem which *)"
          "Bash(git checkout *)"
          "Bash(grep:*)"
          "Bash(gs --versionj)"
          "Bash(gs bc *)"
          "Bash(gs branch *)"
          "Bash(gs log *)"
          "Bash(gs ls:*)"
          "Bash(gs upstack *)"
          "Bash(ls:*)"
          "Bash(mise exec *)"
          "Bash(node:*)"
          "Bash(python3:*)"
          "Bash(rtk aws sts get-caller-identity *)"
          "Bash(rtk find *)"
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
          "Bash(rtk grep *)"
          "Bash(rtk ls *)"
          "Bash(rtk make rspec *)"
          "Bash(rtk proxy aws sts get-caller-identity *)"
          "Bash(rtk proxy cat *)"
          "Bash(rtk proxy find *)"
          "Bash(rtk proxy gh checks *)"
          "Bash(rtk proxy gh pr diff *)"
          "Bash(rtk proxy gh pr edit *)"
          "Bash(rtk proxy gh pr status *)"
          "Bash(rtk proxy gh pr view *)"
          "Bash(rtk proxy gh run view *)"
          "Bash(rtk proxy git --no-pager diff *)"
          "Bash(rtk proxy git branch *)"
          "Bash(rtk proxy git diff *)"
          "Bash(rtk proxy git log *)"
          "Bash(rtk proxy git show *)"
          "Bash(rtk proxy git status)"
          "Bash(rtk proxy grep *)"
          "Bash(rtk proxy ls *)"
          "Bash(rtk proxy make rspec *)"
          "Bash(rtk proxy proxy cat *)"
          "Bash(rtk proxy read *)"
          "Bash(rtk proxy rubocop *)"
          "Bash(rtk proxy wc *)"
          "Bash(rtk read *)"
          "Bash(rtk rubocop *)"
          "Bash(rtk wc *)"
          "Bash(ruby:*)"
          "Bash(sesh list *)"
          "Bash(sesh list *)"
          "Bash(tail:*)"
          "Bash(tmux show-options *)"
          "Bash(xargs cat *)"
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
