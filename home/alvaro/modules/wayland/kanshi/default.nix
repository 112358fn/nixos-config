{ pkgs, ... }:
{
  services.kanshi.enable = true;
  home.packages = [pkgs.wdisplays];
}
