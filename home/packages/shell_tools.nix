{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pass
    fish
    starship
    zellij
    direnv
    bat
    eza
    ripgrep
    fzf
    yazi
    gnused
    helix
    zk
    taskwarrior3
    ghq
    git
    fswatch
    rclone
    duckdb
  ];
}
