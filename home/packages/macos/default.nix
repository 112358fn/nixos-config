{ pkgs, ... }:
{
  home.packages = with pkgs; [
    raycast
    ice-bar
    aerospace
    betterdisplay
  ];
  home.file = {
  ".config/aerospace/aerospace.toml".source = ./config/aerospace/aerospace.toml;
  };
}
