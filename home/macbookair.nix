{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home = {
    username = "alvaro";
    homeDirectory = "/home/alvaro";
    stateVersion = "25.05";
  };
  imports = [
    ../packages/nvim.nix
    ../packages/shell_tools.nix
    ../packages/gui.nix
    ../packages/k8s_tools.nix
    ../packages/macos
    ../packages/gnupg
    ../packages/ssh
  ];
}
