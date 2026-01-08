{ rails-ai-agents, config, ... }:
let
  # Default to "37signals_agents" for personal machine, override via CLAUDE_AGENTS_SUBFOLDER for work
  agentsSubfolder = config.home.sessionVariables.CLAUDE_AGENTS_SUBFOLDER or "37signals_agents";
in
{
  home.file.".claude/agents" = {
    source = "${rails-ai-agents}/${agentsSubfolder}";
    recursive = true;
  };
}
