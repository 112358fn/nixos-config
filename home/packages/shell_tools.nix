{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pass
    zellij
    bat
    eza
    ripgrep
    fzf
    yazi
    yadm
    gnused
    zk
    taskwarrior3
    ghq
    git
    fswatch
    rclone
    duckdb
  ];
}
