{
  rails-ai-agents,
  config,
  lib,
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
          "Bash(chmod +x:*)"
          "Bash(export:*)"
          "Bash(find:*)"
          "Bash(gh:*)"
          "Bash(git:*)"
          "Bash(grep:*)"
          "Bash(ls:*)"
          "Bash(make:*)"
          "Bash(node:*)"
          "Bash(python3:*)"
          "Bash(ruby:*)"
          "Bash(tail:*)"
          "Read"
          "Search"
          "WebFetch(domain:github.com)"
          "mcp__claude_ai_Notion__notion-fetch"
          "mcp__graphite__run_gt_cmd"
          "mcp__serena__*"
        ];
      };
    };

    commandsDir = ../dotfiles/.claude/commands;

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
        ];
      };
    };

    # NOTE: disabled for now
    # agentsDir = "${rails-ai-agents}/${agentsSubfolder}";
  };
}
