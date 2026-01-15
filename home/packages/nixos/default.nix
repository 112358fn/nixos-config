{ pkgs, ... }:
{
  imports = [
    ./wm.nix
    ./ghostty.nix
  ];
  home.packages = with pkgs; [
    firefox
    ungoogled-chromium
  ];
}
