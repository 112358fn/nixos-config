{ config, pkgs, ...}:
{
  programs.home-manager.enable=true;
  home = {
    username = "alvaro";
    homeDirectory = "/home/alvaro";
    stateVersion = "25.05";
  };
}
