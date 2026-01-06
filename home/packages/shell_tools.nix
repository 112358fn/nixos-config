{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pass
    fish
    starship
    zellij
    direnv
    yadm
    chezmoi
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
    gh
    git
    fswatch
    rclone
    duckdb
    unstable.uv
  ];
}
