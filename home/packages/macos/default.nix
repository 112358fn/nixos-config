{ pkgs, ... }:
{
  home.packages = with pkgs; [
    raycast
    ice-bar
    unstable.aerospace
  ];
  home.file = {
  ".config/aerospace/aerospace.toml".source = ./config/aerospace/aerospace.toml;
  };
}
