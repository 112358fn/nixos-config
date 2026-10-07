{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    llm-agents.claude-agent-acp
  ];
  programs.claude-code = {
    enable = true;
    configDir = "${config.xdg.configHome}/claude";
    package = pkgs.llm-agents.claude-code;
  };
}
