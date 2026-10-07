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
  # Out-of-store symlink so CLAUDE.md stays editable without a rebuild.
  home.file."${config.programs.claude-code.configDir}/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/home/alvaro/modules/claude/CLAUDE.md";
}
