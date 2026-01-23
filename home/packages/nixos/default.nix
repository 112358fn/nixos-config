{ pkgs, ... }:
{
  imports = [
    ./wm.nix
  ];
  home.packages = with pkgs; [
    ghostty
    firefox
    ungoogled-chromium
  ];
}
