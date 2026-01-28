{ rails-ai-agents, config, ... }:
let
  # Default to "37signals_agents" for personal machine, override via CLAUDE_AGENTS_SUBFOLDER for work
  agentsSubfolder = config.home.sessionVariables.CLAUDE_AGENTS_SUBFOLDER or "37signals_agents";
in
{
  # Claude Code configuration (~/.claude/)
  # - agents/: Custom Claude agents
  # - commands/: Custom commands (future)
  # - hooks/: Git hooks (future)
  # - plugins/: Editor plugins (future)

  # NOTE: disabled for now
  # home.file.".claude/agents" = {
  #   source = "${rails-ai-agents}/${agentsSubfolder}";
  #   recursive = true;
  # };

  # Claude commands
  home.file.".claude/commands" = {
    source = ../dotfiles/.claude/commands;
    recursive = true;
  };
}
