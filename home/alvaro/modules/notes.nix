{ pkgs, ... }:
{
  programs.zk.enable = true;
  home.packages = with pkgs; [ unstable.obsidian ];

  home.sessionVariables.ZK_NOTEBOOK_DIR = "$HOME/Documents";
}
